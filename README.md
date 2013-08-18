Oauth2 authentication should work with any Oauth2 provider, but this
guide makes some assumptions:

Assumptions
===========
1. You have an existing Rails app.
2. You want a private forum, accesible only to users of your existing
app.


Your Existing App
=================

Make your existing app an Oauth2 provider. I recommend the [Doorkeep
Railscast](http://railscasts.com/episodes/353-oauth-with-doorkeeper).

Generate your Oauth Application ID and Application Secret. You'll need
to include both of these in your environment.


Install (this) Plugin
=====================
Clone this plugin and modify env.sh.example to your needs. You'll have
to make sure those environment variables are available to your
application.


Configure Discourse
===================

Log in as the admin user and disable all authentication types.
Your plugin authentication type doesn't need to be explicitly enabled.
Any authentication provider in your plugin is enabled by default.

Include your styles in your plugin.


