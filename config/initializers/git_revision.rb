module Dashous
  REVISION = (ENV['REVISION'] || `git log --pretty=format:'%h' -n 1`).freeze
end
