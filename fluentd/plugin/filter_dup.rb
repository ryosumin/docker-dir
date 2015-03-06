module Fluent
  class DupFilter < Filter
    Plugin.register_filter('dup', self)

    config_param :firstline, :string, :default => nil

    def configure(conf)
      super
      @msgbuf = {}
      @buffered = {}
      @firstline = Regexp.new(@firstline[1..-2])
    end

    def filter_stream(tag, es)
      new_es = MultiEventStream.new
      es.each { |time, record|
        begin
          key = record['process']
          msgbuf = @msgbuf[key] ||= []
          buffered = @buffered[key] ||= true

          m = !!(record['message'] =~ @firstline)
          buffered = !m
          msgbuf.push(record['message'])
          unless buffered
            message = msgbuf.pop
            if msgbuf.length > 0
              copied = record.clone
              copied['message'] = msgbuf.join("\r\n")
              new_es.add(time, copied)
            end
            new_es.add(time, record)
            @msgbuf[key] = []
          end
        rescue => e
          router.emit_error_event(tag, time, record, e)
        end
      }
      new_es
    end
  end
end
