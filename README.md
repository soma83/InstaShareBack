# InstaShare API

## Requisites:
In order to get this API up and running you must install these applications on your system:

* Postgresql v12.8 (recommended) or higher.
* Ruby v2.7.4 (recommended) or higher. Visit https://www.ruby-lang.org/en/documentation/installation/ for more info.
* Ruby on Rails v6.1.4.1 (recommended) or higher. Visit https://gorails.com/setup/ubuntu/20.04 for installing Rails in any Ubuntu Linux based environment or https://gorails.com/setup/windows/10 for installing Rails in a Windows environment.

These installations might take several minutes, please be patient.

## Next:
Make sure you have Postgres up and running. This project uses the default Postgres configuration values (for example, user postgres, password postgres), but if you need some other config, you may modify this default configuration in the `/config/database.yml` file.

Also make sure you have the proper Ruby and Rails versions, for that you can run in any terminal: `ruby -v` and `rails -v`. Compare versions to the requisites above.

By default this is configured to use the port 3000, if you need to use some other port, you can edit in the file `/config/puma.rb` the line that says `port ENV.fetch("PORT") { 3000 }`.

If you followed the recommended guide to install Rails then you must have installed `Bundler`. Make sure you have the Bundler v2.1.4 (or higher), for that run this command `bundle -v`. If not recognized the `bundle` (`bundler` works as well) you can install it using this command: `gem install bundler`.

Then, you are good to go!

## How to:
* Clone the repo `git clone https://github.com/soma83/InstaShareBack.git`
* Change to the folder `cd InstaShareBack`
* Install dependencies `bundle install`
* Create the database `rails db:create`
* Run migrations `rails db:migrations`
* Start the project `rails server` (or `rails s`).

This app have its own frontend (https://github.com/soma83/InstaShareFront).

That's it!

**Note:**
This app uses ActiveStorage for saving the files. By default it will save the attachments to the folder `/storage` in the application root. If you wish to change the location you can configure it on `/config/storage.yml`.
