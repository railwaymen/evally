# frozen_string_literal: true

class PaginationService
  PER_PAGE = 25

  def initialize(scope, per_page: nil)
    @scope = scope
    @per_page = (per_page || PER_PAGE).to_i
  end

  def pages
    (@scope.count / @per_page.to_f).ceil
  end

  def paginate(page: 1)
    offset = [(page.to_i - 1) * @per_page, 0].max

    @scope.limit(@per_page).offset(offset)
  end
end
