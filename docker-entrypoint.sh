#!/bin/bash
#
# docker-entrypoint.sh - Start server
#

# Correct permissions
chown -R modelfive:modelfive /app/

# Run as regular user
su - modelfive

# Start app server
bundle exec bin/model_five
