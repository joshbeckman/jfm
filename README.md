# jfm

`jfm` is a tool for interacting with Jekyll frontmatter from the command
line.

In Jekyll, all posts have “frontmatter” at the start of them, that
define certain things about the post:

```
---
layout: post
title: A lovely post
---

Here’s a lovely post
```

The frontmatter is the bit between the `---` and the `---`.

This tool allows you to search for posts based on their frontmatter, and
then manipulate that frontmatter in certain ways. Basically, it makes
doing find-and-replace on Jekyll frontmatter a lot easier.

## Installation

    $ gem install jfm

## Usage

`jfm` offers two commands: `find` and `edit`.

### Finding posts

`find` finds posts that match the given queries. For example, given
a site with only the example post given above, you could find that post
in the following ways:

```
$ jfm find "layout"
_posts/2020-12-02-lovely-post.markdown

$ jfm find "layout: post"
_posts/2020-12-02-lovely-post.markdown

$ jfm find "layout: ~page"
_posts/2020-12-02-lovely-post.markdown

$ jfm find "title: A lovely post"
_posts/2020-12-02-lovely-post.markdown

$ jfm find "title: A lovely post" "layout: post"
_posts/2020-12-02-lovely-post.markdown
```

In short:

* a query of `foo` will match posts that have a variable called `foo`
  regardless of its value
* a query of `foo: bar` will match posts that have a variable called
  `foo` set to the value `bar`
* a query of `foo: ~bar` will match posts that have a variable called
  `foo` that is set to any value *other* than `bar`
* you can pass multiple queries; `find` will return posts that match
  them all

### Editing frontmatter

`edit` edits the frontmatter to set a given value. For example, to set
the layout of every single post to “page”, you could:

```
$ ls _posts/* | jfm edit "layout: page"
```

This pairs well with the `find` command to only edit certain posts:

```
$ jfm find "layout: post" | jfm edit "layout: page"
```

If a variable with that name already exists, it will be replaced; if it
doesn’t exist, it will be created.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jfm. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/jfm/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Jfm project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/jfm/blob/master/CODE_OF_CONDUCT.md).
