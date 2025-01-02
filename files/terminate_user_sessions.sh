#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: sudo ./terminate_user_sessions.sh username"
  exit 1
fi

USERNAME="$1"
MAX_RETRIES=5     # Maximum number of retries
RETRY_COUNT=0     # Initialize retry counter

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
  # Check if there are any processes running for the user
  USER_PROCESSES=$(pgrep -u "$USERNAME")

  if [ -z "$USER_PROCESSES" ]; then
    echo "No running processes found for user $USERNAME."
    exit 0
  else
    echo "Attempt $(($RETRY_COUNT + 1)): Terminating processes for user $USERNAME..."

    if [ $RETRY_COUNT -eq 0 ]; then
      # Terminate processes with SIGTERM
      sudo pkill -u "$USERNAME"
    else
      # Forcefully terminate any remaining processes
      sudo pkill -KILL -u "$USERNAME"
    fi

    # Wait for processes to exit gracefully
    sleep 5

    echo "Processes for user $USERNAME have been terminated."

    # Increment the retry count
    RETRY_COUNT=$(($RETRY_COUNT + 1))
  fi
done

# Final check after max retries
USER_PROCESSES=$(pgrep -u "$USERNAME")

if [ -z "$USER_PROCESSES" ]; then
  echo "All processes for user $USERNAME have been terminated after $RETRY_COUNT attempts."
  exit 0
else
  echo "Unable to terminate all processes for user $USERNAME after $MAX_RETRIES attempts."
  exit 1
fi

