module ActiveRecord::QueryMethods
  class WhereIsArel
    attr_accessor :arel_field

    def initialize(arel_field)
      self.arel_field = arel_field
    end

    def >(other)
      arel_field.gt parse_other(other)
    end

    def >=(other)
      arel_field.gteq parse_other(other)
    end

    def <(other)
      arel_field.lt parse_other(other)
    end

    def <=(other)
      arel_field.lteq parse_other(other)
    end

    def ==(other)
      arel_field.eq parse_other(other)
    end

    def !=(other)
      arel_field.not_eq parse_other(other)
    end

    def in?(other)
      arel_field.eq_any parse_other(other)
    end

    def method_missing(method_name, params = {})
      return arel_field.send(method_name, params) if arel_field.respond_to? method_name

      super
    end

    private

    def parse_other(other)
      other.is_a?(WhereIsArel) ? other.arel_field : other
    end
  end

  class WhereIs
    attr_accessor :result

    def initialize(arel, &block)
      @arel = arel
      self.result = instance_exec(&block)
    end

    def method_missing(method_name, _params = {})
      WhereIsArel.new @arel[method_name]
    end
  end

  class WhereChain
    def is(&block)
      opts = sanitize_forbidden_attributes WhereIs.new(arel_table, &block).result
      where_clause = @scope.send(:where_clause_factory).build(opts, {})
      @scope.where_clause += where_clause

      @scope
    end

    def is_not &block
      self.not WhereIs.new(arel_table, &block).result
    end
  end
end
