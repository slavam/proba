class ApplicationController < ActionController::Base
  before_filter :force_utf8_params
  protect_from_forgery

def force_utf8_params
  traverse = lambda do |object, block|
    if object.kind_of?(Hash)
      object.each_value { |o| traverse.call(o, block) }
    elsif object.kind_of?(Array)
      object.each { |o| traverse.call(o, block) }
    else
      block.call(object)
    end
    object
  end
  force_encoding = lambda do |o|
    o.force_encoding(Encoding::UTF_8) if o.respond_to?(:force_encoding)
  end
  traverse.call(params, force_encoding)
end
  
private
  def set_charset
    @@charset='UTF-8'
#    @headers["Content-Type"] = "text/html; charset=utf-8"
  end

# Extension of String class to handle conversion from/to
# UTF-8/ISO-8869-1
class ::String
require 'iconv'
    
#
# Return an utf-8 representation of this string.
#
        def to_utf
            begin
                Iconv.new("utf-8", "cp1251").iconv(self)
#                Iconv.new("cp1251", "cp1251").iconv(self)
            rescue Iconv::IllegalSequence => e
                STDERR << "!! Failed converting from UTF-8 -> cp1251 (#{self}). Already the right charset?"
                self
            end
        end

        #
        # Convert this string to cp1251
        #
        def to_1251
            begin
                Iconv.new("cp1251", "utf-8").iconv(self)
            rescue Iconv::IllegalSequence => e
                STDERR << "!! Failed converting from cp1251 -> UTF-8 (#{self}). Already the right charset?"
                self
            end
        end
    end

end
