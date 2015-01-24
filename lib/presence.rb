module Presence
  def call(value)
    result = @matchings.lazy
      .map { |fn| fn.(value) }
      .detect &:present?

    return result unless result.nil?
    return yield value if block_given?

    raise NoMatchError
  end

  def maybe(&block)
    (@matchings ||= []) << block
  end
end

class NoMatchError < StandardError; end
