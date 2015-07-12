apt-get update
apt-get -y install nginx unicorn libsqlite3-dev sqlite git bundler ruby-rmagick libmagickwand-dev
mkdir -p /usr/share/nginx/squashLeague/{releases,repo,shared}
mkdir -p /usr/share/nginx/squashLeague/shared/{db,vendor,log}
useradd deploy
mkdir -p /home/deploy/.ssh
cp /root/.ssh/authorized_keys /home/deploy/.ssh/
chown -R deploy:deploy /home/deploy/.ssh
chown -R deploy:deploy /usr/share/nginx/squashLeague
chmod 600 /home/deploy/.ssh/authorized_keys

/bin/cp -f /vagrant/install_scripts/nginx.conf /etc/nginx/
#/bin/cp -f /vagrant/install_scripts/unicorn.conf /etc/


sed -i '/^APP_ROOT/c\APP_ROOT=\"/usr/share/nginx/squashLeague\"' /etc/default/unicorn
sed -i '/^PID/c\PID=\"$APP_ROOT/shared/unicorn.pid\"' /etc/default/unicorn
sed -i '/^CONFIG_RB/c\CONFIG_RB=\"$APP_ROOT/current/config/unicorn.rb\"' /etc/default/unicorn
sed -i '/^UNICORN_OPTS/c\UNICORN_OPTS=\"-D -c $CONFIG_RB -E production\"' /etc/default/unicorn
