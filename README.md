# Form-object-sample

This is a code sample taken from a project that I worked on while an apprentice Ruby on Rails developer making APIs for use with mobile apps.  The full project was a server for a REST API.  This sample, however, is for the admin portal where users are created, edited and deleted.

I used a form object because the form deals with both the User and Profile models. Form objects are a DRY-er way of dealing with this than nested attributes in Rails.  When our team modeled the data for the server, we chose to keep authentication and log in information on the User model and all other attributes related to an employee on the Profile model.

For my work on the project, I worked on the migrations pertinent to the User, Profile, Hire Type and Team models, as well.  I also did the styling and JavaScript relevant to the form.

My teammates were primarily responsible for the base styling and sidebar in the app.  The wireframes were created by designers on the team.  The Profile index, which I've pared down to bare bones here, was the work of one of my colleagues.  For this code sample, I have also removed all features required authentication.

## To Do
- [ ] fix bug with photo not displaying

## Getting Started

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/thoughtbot/laptop

After setting up, you can run the application using [foreman]:

    % foreman start

If you don't have `foreman`, see [Foreman's install instructions][foreman]. It
is [purposefully excluded from the project's `Gemfile`][exclude].

[foreman]: https://github.com/ddollar/foreman
[exclude]: https://github.com/ddollar/foreman/pull/437#issuecomment-41110407

## Guidelines

Use the following guides for getting things done, programming well, and
programming in style.

* [Protocol](http://github.com/thoughtbot/guides/blob/master/protocol)
* [Best Practices](http://github.com/thoughtbot/guides/blob/master/best-practices)
* [Style](http://github.com/thoughtbot/guides/blob/master/style)
