require 'active_support/core_ext/module/delegation'
require 'active_record/relation'

module Nthrecord
  module ActiveRecord
    
    module Relation
      
      def nthrecord(input = nil)
        first_record = input.nil?
        input = input || 1 
        relation = clone
      
        # keep these values for the scope
        original_include = relation.includes_values
        
        # purge values
        relation.select_values = []
        relation.includes_values = []
      
        # query for id 
        id_only_relation = relation.select("#{table_name}.id")
        id_results = connection.select_all(id_only_relation.to_sql)
      
        
        if input == 1 && id_results.length > 0
         
          ids = id_results.map(&:values).flatten
        else
         
            b = (input - 1).step(id_results.size - 1, input).map { |i| id_results[i] }
            ids = b.map(&:values).flatten

        end
  
        # setup for final query
          final_scope = klass.includes(original_include)

        # query for desired ids
          records = final_scope.where(:id => ids)      
       
        # return value 
        if first_record
         records.first
        else
          records
        end
      end

    end 
    
    module Base
      def nthrecord(input = nil)
        relation.nthrecord(input)
      end
    end 
    
    
  end
end 

class ActiveRecord::Relation
  include Nthrecord::ActiveRecord::Relation
end

class ActiveRecord::Base
  extend Nthrecord::ActiveRecord::Base
end
