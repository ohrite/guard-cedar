# Guard::Cedar [![Build Status](https://secure.travis-ci.org/ohrite/guard-cedar.png)](http://travis-ci.org/ohrite/guard-cedar)[![Dependency Status](https://gemnasium.com/ohrite/guard-cedar.png)](https://gemnasium.com/ohrite/guard-cedar)[![Code Climate](https://codeclimate.com/github/ohrite/guard-cedar.png)](https://codeclimate.com/github/ohrite/guard-cedar)

guard-cedar automatically recompiles your source and launches the Cedar spec runner application when files are modified.

Install
-------

Please be sure to have [Guard](https://github.com/guard/guard) installed before continue.

Install the gem:

```
$ gem install guard-cedar
```

Add it to your Gemfile (inside development group):

``` ruby
group :development do
  gem 'guard-cedar'
end
```

Add guard definition to your Guardfile by running this command:

```
$ guard init cedar
```

You will need to edit the Guardfile 

``` ruby
guard 'cedar', :project_path => 'YourProject.xcodeproject', :target => 'YourSpecs' do
  watch(%r{^YourSpecs/.+Spec\.mm$})
  watch(%r{^YourProject/.+(\.m|\.h)$})
end
```


Usage
-----

Please read [Guard usage doc](https://github.com/guard/guard#readme)


Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Send me a pull request. Bonus points for topic branches.


Thanks and Attribution
----------------------

* [Thibaud Guillaume-Gentil](https://github.com/thibaudgg) for guard-rspec
* [Adam Milligan](https://github.com/amilligan) for Cedar
* [Jonah Williams](https://github.com/jonah-carbonfive) for pairing


License
-------
See LICENSE for more information.
