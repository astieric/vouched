class SearchesController < ApplicationController

  def autocomplete 
    if request.xhr?
      render :json => (City.find_by_sql("SELECT CT.latitude, CT.longitude, CONCAT_WS(',',CT.name,R.name,C.code) AS name
                                         FROM cities AS CT
                                           INNER JOIN regions AS R ON CT.region_id = R.id
                                           INNER JOIN countries as C ON CT.country_id = C.id
                                         WHERE CT.name LIKE '%#{params[:l]}%'
                                         UNION ALL
                                         SELECT R.latitude, R.longitude, CONCAT_WS(',',R.name,C.code) AS name
                                         FROM regions AS R 
                                           INNER JOIN countries as C ON R.country_id = C.id
                                         WHERE R.name like '%#{params[:l]}%'
                                         UNION ALL
                                         SELECT latitude, longitude, fullname AS name
                                         FROM countries 
                                         WHERE fullname like '%#{params[:l]}%'").to_json)
    end
  end

  def show
    search_string = 'asdfsfsdfsfdasdf454hasuidhfihai'
    search_string = params[:q] unless params[:q].empty?
    @search_type = params[:type] || "all"

    case @search_type
      when "all"
        @search = Sunspot.search(Archetype, City, Company, Contact, Country, Identity, Industry, Region, School, Subindustry, User) do
          keywords search_string
          order_by :created_at, :desc
          paginate(:page => params[:page], :per_page => 10)
          with(:coordinates).near(params[:lat], params[:lng], :boost => 2, :precision => 5) unless (params[:lat].blank? || params[:lng].blank? )
        end

      when "users"
        @search = Sunspot.search(User, Identity) do
          keywords search_string
          order_by :created_at, :desc
          paginate(:page => params[:page], :per_page => 10)
        end

      when "vouches"
        @search = Sunspot.search(Archetype, Identity, User) do
          with(:vouch_terms, params[:q].to_s.gsub(","," ").split.to_a) 
          order_by :created_at, :desc
          paginate(:page => params[:page], :per_page => 10)
      end

      when "jobs"
        @search = Sunspot.search(Job) do
          keywords search_string
          order_by :created_at, :desc
          paginate(:page => params[:page], :per_page => 10)
          with(:coordinates).near(params[:lat], params[:lng], :boost => 2, :precision => 5) unless (params[:lat].blank? || params[:lng].blank? )
        end

      when "archetypes"
        @search = Sunspot.search(Archetype) do
          keywords search_string
          order_by :created_at, :desc
          paginate(:page => params[:page], :per_page => 10)
        end
      when "companies"
        @search = Sunspot.search(Company) do
          keywords search_string
          order_by :created_at, :desc
          paginate(:page => params[:page], :per_page => 10)
          with(:coordinates).near(params[:lat], params[:lng], :boost => 2, :precision => 5) unless (params[:lat].blank? || params[:lng].blank? )
        end

    end

  end

end