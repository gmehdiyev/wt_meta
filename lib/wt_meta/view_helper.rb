module WtMeta
   module ViewHelper

    def meta
      @meta ||= Meta.new
    end

    def render_meta_tags(meta={})

      self.meta.set_defaults(meta)
      self.meta.get_tags(self)
    end

    def title(title=nil, substitution={})
      title = title.to_s % substitution
      self.meta.set(:title, title)
    end

    def description(description=nil)
      self.meta.set(:description, description)
    end

    def meta_image(image=nil)
      self.meta.set(:image, image)
    end

   end
end
