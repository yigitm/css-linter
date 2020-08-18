<h1 align="center">Ruby-CSS-Linters</h1>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![Github Issues](https://img.shields.io/badge/GitHub-Issues-orange)](https://github.com/yigitm/ruby-linter/issues)
[![GitHub2 Pull Requests](https://img.shields.io/badge/GitHub-Pull%20Requests-blue)](https://github.com/yigitm/ruby-linter/pulls)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

[![Made By](https://img.shields.io/badge/Made%20By-Yigit%20Mersin-red)](https://github.com/yigitm)

</div>
<p align="center">
  <img src="https://rawcdn.githack.com/ruby-lint/ruby_lint/cb3e0843f3b1cc7d3663dcc8877d4ce75458f16c/logo/ruby-lint-logo.png" alt="RuboCop Logo"/>
</p>

---

## 📝 Outline

<p align="center">
About&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
Built with&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
Installing&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
Style Guide&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
Author
</p>

## 🧐 About <a name = "about"></a>

<h3 align="center">
This project consists of building a simple CSS linter focusing on Ruby's best practices by checking the Linter cases based on some common mistakes that almost every beginner developer experienced.</h3>

---

## 🔧 Built with<a name ="builtwith"></a>

- [Ruby](https://rubyonrails.org/)
- [Ruby Gem - Colorize](https://rubygems.org/gems/colorize/versions/0.8.1)
- RSpec for Ruby Testing

## 🛠 Installing <a name ="installing"></a>

### Pre-requisites

- Ruby installed on local machine. Please go to [this](https://www.ruby-lang.org/en/documentation/installation/) link if you need to install it.

### Usage

Clone this repository on the command promp or console using

```
git clone git@github.com:yigitm/ruby-linter.git
```

```
cd Ruby-Linters
```

Type in the following command to run the linter on a test file

```
ruby bin/main.rb
```

### Testing

Test class methods using RSpec by running the command in the root directory

```
rspec
```

Before testing for using RSpec you can install the gem file by running the command

```
$ bundle install
```

Also make sure you have bundler installed on your system, else run

```
$ gem install bundler
```

or you simply install the the following directly using

```
$ gem install rspec
```

# Style Guide <a name = "styleguide"></a>

## 1. Errors for Syntax

<p>These 'Errors' lints are checking the cases syntax errors</p>

#### - Mising Bracket(s) Case

<b>#bracket_checker</b> lint is checking the missing curly brackets. It displays an error message.

```
.some-title {
  font-weight: lighter;

.some-other-title {
  color: red;
  font-weight: lighter;
}
```

#### - Using Regular Bracket(s) or No Bracket(s)

This lint is checks the case of mixing curly bracket(s) with regular bracket(s) or typing no bracket(s). It displays an error message.

```
# bad
.some-title
  font-weight: lighter;

.some-other-title (
  color: red;
  font-weight: lighter;
)

# good
.some-title {
  font-weight: lighter;
}

.some-other-title {
  color: red;
  font-weight: lighter;
}
```

#### - Empty Rule

This lint is checks the case of leaving empty rule(s). It displays an error message.

```
# bad
.some-title {
}

.{
}

# good
.some-title {
  color: red;
}

.some-other-title {
  font-weight: lighter;
}
```

#### - Missing colon: or semi-colon;

This lint is checks the missing colon(s) or semi-colon(s). It displays an error message.

```
# bad
.some-title {
  color red;
}

.some-other-title {
  font-weight: lighter
}

# good
.some-title {
  color: red;
}

.some-other-title {
  font-weight: lighter;
}
```

## 2. Warnings for good practices

<p>These 'Warning' lints are checking the cases of good CSS practices of using fewer tags and violation of <b>DRY</b> rule</p>

#### - Over use of !important Tag

This lint is checks the over use of !important tag. It displays a warning message if tag is used more than ten.

```
# bad
.some-title {
  color: red !important;
}

.some-other-title {
  font-weight: lighter !important;
}
...usage limit is '10'

# good

...using !important tag less than '10' times
```

#### - DRY (Dont Repeat Yourself) Violation

This lint is checks the <b>DRY</b> rule violations. It displays a warning message.

```
# bad

.some-title {
  font-weight: lighter;
  color: red;
}

.some-other-title {
  font-weight: lighter;
}

# good

.some-title, .some-other-title {
  font-weight: lighter;
}

.some-title {
  color: red;
}
```

## ✒️ Author <a name = "author"></a>

👤 **Yiğit Mersin**

- Github: [@yigitm](https://github.com/yigitm)
- Twitter: [@yigitmersin](https://twitter.com/ygtmrsn)
- Linkedin: [ygtmrsn](https://www.linkedin.com/in/yigitmersin)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/yigitm/ruby-linter/issues).

## 👍 Show your support

Give a ⭐️ if you like this project!

## 📝 License :

This project is [GNU GENERAL PUBLIC LICENSE](<https://www.gnu.org/licenses/why-not-lgpl.html>.) licensed.
