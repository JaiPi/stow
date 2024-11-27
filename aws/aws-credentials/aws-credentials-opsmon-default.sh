#!/bin/bash

# Function to display an initial description of the script
display_initial_description() {
  echo -e "\e[34m---------------- AWS MFA Cerdentials Script --------------------\e[0m"
  echo -e "This script assists setting AWS credentials using MFA."
  echo -e "\e[33mAWS_USER_PROFILE:\e[0m $AWS_USER_PROFILE"
  echo -e "\e[33mAWS_2AUTH_PROFILE:\e[0m $AWS_2AUTH_PROFILE"
  echo -e "\e[33mARN_MFA:\e[0m $ARN_MFA"
  echo -e "\e[33mMFA_Token_Code:\e[0m $MFA_TOKEN_CODE"
  echo -e "\e[34m----------------------------------------------------------------\e[0m"
  echo "" # Adding an extra newline for readability
}

# Function to check AWS CLI installation
check_aws_cli() {
  AWS_CLI=$(which aws)
  if [ $? -ne 0 ]; then
    echo -e "\e[31mAWS CLI is not installed; exiting\e[0m"
    exit 1
  else
    echo -e "Using AWS CLI found at \e[33m$AWS_CLI\e[0m"
    echo "" # Adding an extra newline for readability
  fi
}

# Function to ensure correct usage of the script
ensure_correct_usage() {
  if [ "$#" -ne 1 ]; then
    echo -e "\e[31mUsage: $0 <MFA_TOKEN_CODE>"
    echo -e "Where:"
    echo -e "   <MFA_TOKEN_CODE> = Code from virtual MFA device\e[0m"
    exit 2
  fi
}

# Function to get AWS session token
get_session_token() {
  read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< \
    $(aws sts get-session-token \
      --profile "$AWS_USER_PROFILE" \
      --serial-number "$ARN_MFA" \
      --token-code "$MFA_TOKEN_CODE" \
      --duration "129600" \
      --output text \
      --query 'Credentials.[AccessKeyId, SecretAccessKey, SessionToken]')
}

# Function to update AWS CLI configuration
update_aws_config() {
  aws --profile "$AWS_2AUTH_PROFILE" configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
  aws --profile "$AWS_2AUTH_PROFILE" configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
  aws --profile "$AWS_2AUTH_PROFILE" configure set aws_session_token "$AWS_SESSION_TOKEN"
}

# Function to assume role and get credentials
assume_role_and_get_creds() {
  read AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN <<< \
    $(aws sts assume-role \
      --profile "$AWS_2AUTH_PROFILE" \
      --role-arn "$ROLE_ARN" \
      --role-session-name "$ROLE_SESSION_NAME" \
      --output text \
      --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]')
}

# Caution: Displaying sensitive information
echo_configurations_and_credentials() {
  echo -e "\t\e[34mCredentials ${AWS_2AUTH_PROFILE}\e[0m"
  echo -e "\e[33mAWS_ACCESS_KEY:\e[0m $AWS_ACCESS_KEY_ID"
  echo -e "\e[33mAWS_SECRET_ACCESS_KEY:\e[0m $AWS_SECRET_ACCESS_KEY"
  echo -e "\e[33mAWS_SESSION_TOKEN:\e[0m $AWS_SESSION_TOKEN\e[0m"
}

# Function to check if credentials are retrieved successfully
check_credentials() {
  if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ] || [ -z "$AWS_SESSION_TOKEN" ]; then
    echo -e "\e[31mFailed to retrieve AWS credentials. Exiting.\e[0m"
    exit 4 # exit code 4 represents a credentials error
  fi
}

get_arn() {
  local keyword="$AWS_USER_PROFILE"
  local FILEPATH="/home/alma/aws-credentials/aws-mfa-arns"
  local arn

  # Check if file exists
  if [[ ! -f "$FILEPATH" ]]; then
    echo "\e[31mError: File '$FILEPATH' not found.\e[0m"
    return 1
  fi

  arn=$(awk -F'="' -v k="$keyword" '$1 == k {print $2}' "$FILEPATH" | tr -d '"')

  # Check if ARN was found
  if [[ -z "$arn" ]]; then
    echo "\e[31mError: No ARN found for keyword '$keyword' in '$FILEPATH'.\e[0m"
    return 1
  fi

  echo "$arn"
  return 0
}

# Main execution flow
main() {
  # Global configurations
  AWS_USER_PROFILE="opsmon"
  ARN_MFA="$(get_arn)"
  AWS_2AUTH_PROFILE="default"
  MFA_TOKEN_CODE="$1"

  display_initial_description

  check_aws_cli
  ensure_correct_usage "$@"

  get_session_token

  check_credentials

  echo_configurations_and_credentials

  update_aws_config

  echo -e "\e[32mAWS MFA credentials for '$AWS_USER_PROFILE' have been set on the '$AWS_2AUTH_PROFILE' profile.\e[0m"
}

# Execute main function with all arguments
main "$@"
