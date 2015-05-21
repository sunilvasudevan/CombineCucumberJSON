# Module designed to Merge multiple Cucumber JSON reports in to a single report.
#
# @author : Sunil
#Date : 05.21.2015
#
require 'json'
require 'fileutils'

module MergeCucumberJson

	@final_report =nil
	@file_array = []

	# Method will merge all the file's provided to this method.
	# final_report_name is optional. default name is combined_report.json
	def self.merge_cucumber_json_reports(file_array, final_report_file='combined_report.json')
		file_array.each_with_index do |file_name, index|

			file_content = File.read(File.expand_path(file_name)).to_s
			start_index = file_content.index('{')
			end_index	= file_content.index('}')

			merge_content = file_content[start_index..end_index]
			@final_report << merge_content
			if index <= (file_array.size - 2)
				@final_report << ','
			end

		end
		@final_report << ']'	

		begin
			json_object = JSON.parse(@final_report)
			out_file = File.new(File.expand_path(final_report_file),'w')
			out.write(json_object.to_json)
		rescue => exception
			puts " Error while merging JSON report. #{$!}"
			puts " Backtrace : \n \t #{exception.backtrace.join("\n\t")}"
			exit(1)
		end
	end

end
