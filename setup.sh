#!/bin/bash
# https://github.com/KuJoe/Sendmail-to-SSMTP

# If you're using Debian/Ubuntu change yum to apt-get
yum remove sendmail mailx nail bsd-mailx heirloom-mailx -y
yum install mailx ssmtp -y

# Remove sendmail and symlink to ssmtp
rm -rf /usr/sbin/sendmail
ln -s /usr/sbin/ssmtp /usr/sbin/sendmail

# Write config file for ssmtp
# Change "mydomain.com", "user@mydomain.com", and "API_KEY_FROM_MANDRILL"
# Replace "smtp.mandrillapp.com" with "smtp.sendgrid.net" to use SendGrid, you can specify any other SMTP server also
echo "rewriteDomain=mydomain.com" > /etc/ssmtp/ssmtp.conf
echo "hostname=mydomain.com" >> /etc/ssmtp/ssmtp.conf
echo "mailhub=smtp.mandrillapp.com:587" >> /etc/ssmtp/ssmtp.conf
echo "UseSTARTTLS=YES" >> /etc/ssmtp/ssmtp.conf
echo "AuthUser=user@mydomain.com" >> /etc/ssmtp/ssmtp.conf
echo "AuthPass=API_KEY_FROM_MANDRILL" >> /etc/ssmtp/ssmtp.conf
echo "FromLineOverride=YES" >> /etc/ssmtp/ssmtp.conf
echo "TLS_CA_File=/etc/pki/tls/certs/ca-bundle.crt" >> /etc/ssmtp/ssmtp.conf
echo "" > revaliases

# Sends you a test e-mail to make sure things are working correctly, check the header and make sure it came from Mandrill.
# Change my@email.com
uptime | mail -s "MAIL TEST" my@email.com