module App::Web
  module GetDocument extend Presence
    maybe { |x| Document.find_by(path: x) }
    maybe &RawDocument
  end
end

