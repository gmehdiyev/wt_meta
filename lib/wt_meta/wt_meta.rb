module WtMeta
   class Meta


      def initialize
        @cache = {}
        @meta= {
          separator: ' | ',
          site: nil,
          url: nil,
          title:  nil,
          description: nil,
          image: nil
        }
      end

      def set_defaults(defaults={})
        meta = @meta.reject{|k,v| v.blank?}.reverse_merge defaults
        @meta= meta
      end

      def set(key, value)
        @meta[key] = value unless value.blank?
      end

      def title(view)
        title = "#{@meta[:title]}#{@meta[:separator]}#{@meta[:site]}"
        tags = []
        tags << view.content_tag(:title, title)
        tags << view.tag(:meta, property: 'og:title', content: title)
        tags
      end

      def description(view)
        return if @meta[:description].blank?
        tags = []
        tags << view.tag(:meta, name: 'description', content: @meta[:description])
        tags << view.tag(:meta, property: 'og:description', content: @meta[:description])
        tags
      end

      def og(view)
        tags = []
        tags << view.tag(:meta, property: 'og:site_name', content: @meta[:site])
        tags << view.tag(:meta, property: 'og:type', content: 'website')
        tags << view.tag(:meta, property: 'og:url', content: @meta[:url])
        tags
      end

      def keywords(view)
        return if @meta[:keywords].blank?
        view.tag(:meta, name: 'keywords', content: @meta[:keywords])
      end

      def image(view)

        return if @meta[:image].blank?
        tags = []

        begin
          url = @meta[:image]
          size = @cache[url] || FastImage.size(url)

          @cache[url] = size

          tags << view.tag(:meta, property: 'og:image', content: url)
          tags << view.tag(:meta, property: 'og:image:width', content: size[0])
          tags << view.tag(:meta, property: 'og:image:height', content: size[1])
        rescue => e

        end

        tags
      end

      def get_tags(view)
        tags = []
        tags << title(view)
        tags << description(view)
        tags << keywords(view)
        tags << image(view)
        tags << og(view)

        tags.flatten.join("\n").html_safe
      end


   end
end