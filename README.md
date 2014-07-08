CO<sub>2</sub> sensor backend website
=====================================

*Not complete*

A Ruby on Rails server to manage and store data from CO<sub>2</sub> sensors with the Wildfire board.
The firmware for the WildFire is [here](https://github.com/WickedDevice/CO2Monitor "CO2Monitor Github Repository")

Installation for development
----------------------------
Clone the repository with `git clone git@github.com:WickedDevice/CUCO2_Website.git` in your terminal in the directory you want it in.
Then run `bundle install` to install all the rubygems that this uses.

If you want, run `rake db:create db:migrate db:seed` to populate the database with some entries.

That's it!

Type `rails s` to start the server locally.


Installation and Configuration for production
---------------------------------------------
Sadly, production is a bit harder to setup than just development.

My current server's setup is using digitalocean's 1 click install for ruby on rails. [Here's the tutorial][digitalocean_tutorial]
That pre-installs Unicorn, nginx, and MySQL, which is *very* handy.

### Cloning the app
First ssh into your server:
```bash
ssh user@yourserver
```
Assuming you're setting up using this droplet, you'll need to delete the default app in `/home/rails`
```bash
cd /home/rails/
rm -r *     #be careful with this command.
```
Then clone this repository into wherever you're putting it (in my case `/home/rails`)
```bash
git clone git@github.com:WickedDevice/CUCO2_Website.git
```
If you don't have git installed, you'll need to install it before this step. On Ubuntu this is: `sudo apt-get install git`.

### Environment variables
The rails app expects the environment variables `SECRET_KEY_BASE` and `RAILS_DB_PASSWORD` to be defined. Or you can remove them from `config/secrets.yml` and `config/database.yml` respectively.

For me, this meant that I had to change `/etc/default/unicorn` to include:
```bash
export SECRET_KEY_BASE=whateverMySecretKeyIs

export RAILS_DB_PASSWORD=whateverTheMySQLPasswordIs
```
You can generate a rails SECRET_KEY_BASE with the command `rake secret`.

This server uses a 'rails' user for the MySQL database. RAILS_DB_PASSWORD should be the password for the rails user.

I ended up changing `./config/database.yml` to include the database password because `rails c production` wasn't happy without it.
I've also put the database password in `/etc/profile`, but I don't think you need to.


### Configuring nginx for SSL
It is pretty likely that whatever your setup is will be fairly different from mine, but here is what I did:

I started with [DigitalOcean's tutorial][digitalocean_nginx_ssl_tutorial] for creating an ssl certificate, and once that was working, I added a proper certificate. [This tutorial][nginx_ssl_tutorial] was helpful for that.

I have my .crt and .key files in `/etc/nginx/ssl`, and my `/etc/nginx/sites-available/default` looked like this when I was finished:
```
server {
        listen   80;
        root /home/rails/public;
        server_name aerosense.cc;
        index index.htm index.html;

        location / {
                try_files $uri/index.html $uri.html $uri @app;
        }

#       location ~* ^.+\.(jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|js|mp3|flv|mpeg|avi)$ {
location ~* ^.+\.(jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|mp3|flv|mpeg|avi)$ {
                        try_files $uri @app;
                }

         location @app {
		proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_pass http://app_server;
    }

}

#HTTPS server
server {
        listen   443;
        ssl on;
        ssl_certificate /etc/nginx/ssl/aerosense.crt;
        ssl_certificate_key /etc/nginx/ssl/aerosense.key;

        root /home/rails/public;
        server_name aerosense.cc;
        #server_name _;
        index index.htm index.html;

        location / {
                try_files $uri/index.html $uri.html $uri @app;
        }

#       location ~* ^.+\.(jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|js|mp3|flv|mpeg|avi)$ {
location ~* ^.+\.(jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|mid|midi|wav|bmp|rtf|mp3|flv|mpeg|avi)$ {
                        try_files $uri @app;
                }

         location @app {
		proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_redirect off;
                proxy_pass http://app_server;
    }

}
```

Initializing the database
-------------------------
Everything is setup in the rails app, but the database still needs to be initialized.

This command creates the database, makes sure it is up to date, and adds a bunch of demo data.
```bash
RAILS_ENV=production rake db:create db:migrate db:seed
```
`rake db:seed` adds an admin user with a set username and password. Once this initialization is done, you'll want to login & change the admin user's name and password.
The username is `Example_user`, and the password is `123`.
Alternatively, you can skip the `db:seed` part of the command and just run `db:create` and `db:migrate`, and add entries to the database manually.

Starting the server
-------------------
Now the exciting part: starting up your server.
On my configuration, the following commands start up nginx and Unicorn, but your setup may be different.

```bash
service nginx restart
service unicorn restart
```

Now navigate to your server's IP address in a web browser, and you should see the site live!


Pushing updates to the server
-----------------------------
My current setup isn't using Capistrano, so Capistrano may not work at all.
Instead, I `ssh` into the server and pull from github manually.
Then I run a few things like `bundle install`, `rake assets:precompile RAILS_ENV=production`, `bundle exec rake db:migrate RAILS_ENV=production`, as needed and then restart the server.

Here's a script that does this for me:
```bash
#!/bin/bash
# Pulls the rails app repo from github & restarts it.

#Prints blue
function print_out(){
  printf "\n\e[1;34m>>\t%s\e[0m\n" "$@"
}
 
print_out "Changing directories"
cd /home/rails # This will have to point to wherever the app is
print_out "git pull"
git pull
print_out "bundle install"
bundle install
print_out "Precompiling assets"
bundle exec rake assets:precompile RAILS_ENV=production
print_out "Migrating database"
bundle exec rake db:migrate RAILS_ENV=production
print_out "Restarting server"
service unicorn restart

print_out "nginx can be restarted with 'service nginx restart'"

print_out "Deploy complete"
```
The line with `service unicorn restart` may be incorrect for your setup.


Tests
-----
Testing is setup using [rspec], but the tests are fairly incomplete.
I'm not using a factory anywhere, and I'm sure many other things are wrong with the way I've set things up.

Anyway, if you do want to run the pitiful test suite:
```bash
rspec
```


[digitalocean_tutorial]: https://www.digitalocean.com/community/tutorials/how-to-1-click-install-ruby-on-rails-on-ubuntu-12-10-with-digitalocean/ "How To 1-Click Install Ruby on Rails on Ubuntu 12.10 with DigitalOcean"
[digitalocean_nginx_ssl_tutorial]: https://www.digitalocean.com/community/tutorials/how-to-create-a-ssl-certificate-on-nginx-for-ubuntu-12-04 "How To Create a SSL Certificate on nginx for Ubuntu 12.04"
[nginx_ssl_tutorial]: http://nginx.groups.wuyasea.com/articles/how-to-setup-godaddy-ssl-certificate-on-nginx/2
[rspec]: http://rspec.info/ "rspec gem"



<br>

##### Default README:

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
