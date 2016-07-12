module ActiveFedora
  class SolrService
    def self.query(query, args={})
      raw = args.delete(:raw)
      args = args.merge(:q=>query, :qt=>'standard')
      result = SolrService.instance.conn.post('select', :data=>args)
      return result if raw
      result['response']['docs']
    end
  end
end
