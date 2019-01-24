require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(title body created_at updated_at)
  csv << csv_column_names
  @boards.pluck(*csv_column_names).each do |board|
    csv << board
  end
end