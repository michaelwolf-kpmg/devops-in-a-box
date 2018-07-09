#!/bin/sh

export MM_PASSWORD_ENCODED=$(printf %s $MM_PASSWORD | jq -s -R -r @uri)
MM_CONFIG=${MM_CONFIG:-/mattermost/config/config.json}

# Function to generate a random salt
generate_salt() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 48 | head -n 1
}

if [ ! -f $MM_CONFIG ] 
then
    # create initial config file and generate base salts based on latest template from mattermost
    echo "Creating new config file" $MM_CONFIG
    cp /config.json.save $MM_CONFIG
    jq '.EmailSettings.InviteSalt = "'$(generate_salt)'"' $MM_CONFIG > $MM_CONFIG.tmp && mv $MM_CONFIG.tmp $MM_CONFIG
    jq '.EmailSettings.PasswordResetSalt = "'$(generate_salt)'"' $MM_CONFIG > $MM_CONFIG.tmp && mv $MM_CONFIG.tmp $MM_CONFIG
    jq '.SqlSettings.AtRestEncryptKey = "'$(generate_salt)'"' $MM_CONFIG > $MM_CONFIG.tmp && mv $MM_CONFIG.tmp $MM_CONFIG
else 
    # merge existing config with latest template from mattermost for upgrades and new properties
    echo "Upgrading existing config file" $MM_CONFIG
    jq -s '.[0] * .[1]' /config.json.save $MM_CONFIG > $MM_CONFIG.tmp && mv $MM_CONFIG.tmp $MM_CONFIG
fi

# compile the our template to replace variables
sh -c "envsubst < /config/config.json.template > /config/config.json.compiled"

# merge our overrides with existing config file, reapply our settings
echo "Merging forced settings to configuration file" $MM_CONFIG
jq -s '.[0] * .[1]' $MM_CONFIG /config/config.json.compiled > $MM_CONFIG.tmp && mv $MM_CONFIG.tmp $MM_CONFIG
cat $MM_CONFIG

sh /entrypoint.sh mattermost