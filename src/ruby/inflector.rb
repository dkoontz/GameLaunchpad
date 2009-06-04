# Copyright (c) 2009 GameLaunchpad
# All rights reserved.

# This code is a modified version of the Inflector class
# from the Ruby on Rails project (http://www.rubyonrails.com)
# The original license file is provided below.
#
# Copyright (c) 2005-2009 David Heinemeier Hansson
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module GameLaunchpad
  module Inflector
    # The reverse of +camelize+. Makes an underscored form from the expression in the string.
    #
    # Changes '::' to '/' to convert namespaces to paths.
    #
    # Examples
    #   "ActiveRecord".underscore #=> "active_record"
    #   "ActiveRecord::Errors".underscore #=> active_record/errors
    def underscore()
      self.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    # Constantize tries to find a declared constant with the name specified
    # in the string. It raises a NameError when the name is not in CamelCase
    # or is not initialized.
    #
    # Examples
    #   "Module".constantize #=> Module
    #   "Class".constantize #=> Class
    def constantize()
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ self.to_s
        raise NameError, "#{self.inspect} is not a valid constant name!"
      end

      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end

    # By default, camelize converts strings to UpperCamelCase. If the argument to camelize
    # is set to ":lower" then camelize produces lowerCamelCase.
    #
    # camelize will also convert '/' to '::' which is useful for converting paths to namespaces
    #
    # Examples
    #   "active_record".camelize #=> "ActiveRecord"
    #   "active_record".camelize(:lower) #=> "activeRecord"
    #   "active_record/errors".camelize #=> "ActiveRecord::Errors"
    #   "active_record/errors".camelize(:lower) #=> "activeRecord::Errors"
    def camelize(first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        self.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
      else
        self.to_s[0..0] + camelize(self.to_s)[1..-1]
      end
    end
  end
end

class String
  include GameLaunchpad::Inflector
end

class Symbol
  include GameLaunchpad::Inflector
end
