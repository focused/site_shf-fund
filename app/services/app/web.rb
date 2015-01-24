module App::Web
  module GetDocument extend Presence
    maybe &Document.method(:find_by)
    maybe &RawDocument
  end
end

