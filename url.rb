require 'uri'

class URL
  class InvalidURLError < RuntimeError
  end

  ##############################################################################
  # Constructors

  attr_reader :protocol, :userinfo, :host, :port, :registry, :path, :opaque,
              :query, :fragment

  def initialize(url)
    @protocol,
    @userinfo,
    @host,
    @port,
    @registry,
    @path,
    @opaque,
    @query,
    @fragment = URI.split(url)

  rescue URI::InvalidURIError => e
    raise(URL::InvalidURLError, e.message)
  end

  ##############################################################################
  # Conditionals

  def opaque?
    @opaque.present?
  end

  def only_path?
    return false if @protocol ||
                    @userinfo ||
                    @host     ||
                    @port     ||
                    @registry ||
                    @opaque   ||
                    @query    ||
                    @fragment

    true
  end

  ##############################################################################
  # Inspectors

  # Take the URL pieces and re-construct them into a functional string
  def to_s
    [
      ("#{@protocol}://" if @protocol),
      ("#{@userinfo}@" if @userinfo),
      @host,
      (":#{@port}" if @port),
      @registry,
      @path,
      ("?#{@query}" if @query),
      ("##{@fragment}" if @fragment)
    ].join
  end
  alias url to_s
  alias full to_s

  # Return the URI of the URL string
  def uri
    URI.parse(to_s)
  end

  # Return the URL as it's components in an array
  def split
    [@protocol,
     @userinfo,
     @host,
     @port,
     @registry,
     @path,
     @opaque,
     @query,
     @fragment]
  end

  def to_h
    [@protocol,
     @userinfo,
     @host,
     @port,
     @registry,
     @path,
     @opaque,
     @query,
     @fragment]
  end

  def decode
    URI.decode_www_form_component(to_s)
  end

  def inspect
    "#<#{self.class} #{self}>"
  end

  ##############################################################################
  # Modifiers

  def +(other)
    append(other)
  end
  alias / +

  def join(*args)
    return self if args.empty?

    url = dup

    args.each do |arg|
      arg = URL.new(arg) unless arg.is_a? URL
      url += arg
    end

    url
  end

  def encode_join(*args)
    return self if args.empty?

    args.map! { |arg| ERB::Util.url_encode(arg) }
    join(*args)
  end

  private

    def append(other)
      other = URL.new(other) unless other.is_a? URL

      if other.only_path?
        @path = [path, other.path].join('/')
        return self
      end

      URL.new(URI.join(to_s, other.to_s).to_s)
    end
end
