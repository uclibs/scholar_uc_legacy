class Report
  require 'csv'

  def self.report_location
    [Rails.root, 'vendor', report_title].join('/')
  end

  def self.create_report
    CSV.open(report_location, "w", options = { col_sep: "\t" }) do |csv|
      csv << report_header
      report_objects.each do |object|
        csv << report_row(object)
      end
    end
  end

  private

  def self.report_title
    self.name.underscore + '.csv'
  end

  def self.report_header
    fields.collect { |field| field.keys[0] }   
  end

  def self.report_row(object)
    res = fields(object).collect { |field| field.values.join("|").gsub(/\n/, " ") }   
    byebug
  end
end

