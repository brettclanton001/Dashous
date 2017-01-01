module SlugService extend self

  def generate(name)
    indexify format(name)
  end

  private

  def format(name)
    name.downcase
      .gsub(/['.-]/, '')
      .tr('^A-Za-z0-9', '_')
      .gsub('__', '_')
      .slice(0, 40)
  end

  def indexify(slug)
    this_slug = slug
    (1..1000).each do |i|
      found = TradeRequest.where(slug: this_slug).exists?
      if found
        this_slug = "#{slug}_#{i}"
        next
      else
        return this_slug
      end
    end
  end

end
