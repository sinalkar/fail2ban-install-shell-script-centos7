sudo yum install -y epel-release
sudo yum install -y fail2ban

sudo systemctl enable fail2ban

cat > /etc/fail2ban/jail.local << EOF
  
[DEFAULT]
# Ban hosts for one hour:
bantime = 3600

# Override /etc/fail2ban/jail.d/00-firewalld.conf:
banaction = iptables-multiport

[sshd]
enabled = true

EOF

# Ignore following IP pool from ban:
sed -i '/ignoreip = 127.0.0.1\/8/c\ignoreip = 10.0.29.0/24\' /etc/fail2ban/jail.conf

sudo systemctl restart fail2ban

sudo fail2ban-client status

sudo fail2ban-client status sshd
