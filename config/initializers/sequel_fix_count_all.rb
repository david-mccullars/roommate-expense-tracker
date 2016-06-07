module Sequel::FixCountAll
  def count(*args)
    if args == [:all]
      super()
    else
      super(*args)
    end
  end
end
Sequel::Dataset.prepend(Sequel::FixCountAll)
