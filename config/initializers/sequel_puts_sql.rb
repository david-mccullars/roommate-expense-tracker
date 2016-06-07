# This little monkey patch provides a very nifty convenience method for datasets:
#
#    SomeModel.some_dataset.puts_sql
#
# Like its cousin .sql, this will output the SQL of the dataset, but it will do so in
# a formatted fashion.  VERY helpful for big, nasty queries.
module Sequel::PutsSql
  def puts_sql
    request = URI.encode_www_form(
      sql: self.sql,
      reindent: 1,
      keyword_case: 'upper',
    )
    Net::HTTP.start('sqlformat.org', 80) do |http|
      puts JSON.parse(http.post('/api/v1/format', request).body).fetch('result')
    end
  end
end
Sequel::Postgres::Dataset.prepend(Sequel::PutsSql)
