# Example usage:
#   switch-to-php-version 8.4
#
# Assumptions:
# - OSX
# - Using Homebrew to manage PHP installations
#
# This:
# - checks the user has provided what we assume to be the version number of their desired PHP
# - checks that the desired version is different from the current PHP version 
# - checks that the desired version is installed
# - unlinks from brew whatever the current PHP version is
# - links into brew the desired version 
# - reports what the current version of PHP now is


TARGETPHPVERSION=$1

if [ -z TARGETPHPVERSION ]; then
	echo "No target PHP version provided, exiting."
	exit 1
fi

CURRENTPHPVERSION=$(php --version | grep '^PHP' | sed -E 's/PHP ([0-9]+\.[0-9]+).*/\1/')

if [ "$TARGETPHPVERSION" = "$CURRENTPHPVERSION" ]; then
	echo "PHP is already at the desired version $CURRENTPHPVERSION. Nothing to do. Exiting."
	exit 2
fi


echo "Current PHP version is: $CURRENTPHPVERSION"

echo "Availabe installed PHP versions:"
brew ls --versions | grep '^php[ @]'

echo "Trying to switch to PHP version $TARGETPHPVERSION"
FOUNDSTRINGRELATINGTOINSTALLEDTARGETVERSION=$(brew ls --versions | grep '^php[ @]' | grep $TARGETPHPVERSION)
if [ ${#FOUNDSTRINGRELATINGTOINSTALLEDTARGETVERSION} -eq 0 ]; then
	echo "Doesn't look like PHP version $TARGETPHPVERSION is installed. Try installing it and reissuing the command. Exiting."
	exit 3
fi

brew unlink php@$CURRENTPHPVERSION
brew link php@$TARGETPHPVERSION
echo "These are now the details of the current PHP version:"
php --version
