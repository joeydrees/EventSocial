# [![Application icon](https://raw.githubusercontent.com/rdt712/EventSocial/profile/app/assets/images/readme-logo.png)][icon]
[icon]: https://raw.githubusercontent.com/rdt712/EventSocial/profile/app/assets/images/readme-logo.png 

# Event Social
[Event Social Live Demo][website]

[website]: https://eventsocial.herokuapp.com

#### Events made social, powered by Twitter.
Social media is now one of the most important tools planners and marketers can use to disseminate information about events and meetings, interact with attendees, solicit feedback, and create year-round engagement with a target audience. Why not combine event planning and social media?

## Dependencies

#### Install Ruby
First, make sure you have ruby installed.

**On a Mac**, open `/Applications/Utilities/Terminal.app` and type:

    ruby -v

If the output looks something like this, you're in good shape:

    ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin15]

If the output looks more like this, you need to [install Ruby][ruby]:
[ruby]: https://www.ruby-lang.org/en/downloads/

    ruby: command not found

**On Linux**, for Debian-based systems, open a terminal and type:

    sudo apt-get install ruby-dev

or for Red Hat-based distros like Fedora and CentOS, type:

    sudo yum install ruby-devel

(if necessary, adapt for your package manager)

**On Windows**, you can install Ruby with [RubyInstaller][].
[rubyinstaller]: http://rubyinstaller.org/downloads/

#### Install Rails
Next, you will need to install Rails.

Here is a guide to install [Rails][rails].
[rails]: http://installrails.com/steps/choose_os

#### Required Ruby and Rails version
	ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-darwin15]

	rails 4.2.5.1

## Download and Set Up

Download the [zip file][zip] from GitHub and unzip the zip file to a directory of your choice.
[zip]: https://github.com/rdt712/EventSocial/archive/master.zip

#### Bundle Install
	cd /eventsocial/directory
	bundle install

#### Migrate the Database
	rake db:migrate 

#### Start the Server
	rails server