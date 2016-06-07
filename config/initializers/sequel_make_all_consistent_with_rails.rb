=begin
module Sequel::MakeAllConsistentWithRails
  def all
    self
  end
end
Sequel::Dataset.prepend(Sequel::MakeAllConsistentWithRails)
=end
