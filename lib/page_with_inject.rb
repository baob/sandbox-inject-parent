require 'pry'

class Page

  attr_reader :parent, :parent_id, :slug

  def initialize(opts = {})
    @parent = opts[:parent]
    @parent_id = parent.object_id if @parent
    @slug = opts[:slug]
  end
end

class ParentPages
  include Enumerable

  def initialize(page)
    @page = page
  end

  def each
    this_page = @page
    while this_page
      yield this_page
      this_page = this_page.parent
    end
  end
end

page0 = Page.new(slug: 'top_slug')
page1 = Page.new(slug: 'next_slug', parent: page0)
page2 = Page.new(slug: 'yet_another_slug', parent: page1)
page3 = Page.new(slug: 'last_slug', parent: page2)

def nested_page_path(page)
  ParentPages.new(page).to_a.reverse.inject(''){ |result, p| result + '/' + p.slug }
end

puts nested_page_path(page3)


