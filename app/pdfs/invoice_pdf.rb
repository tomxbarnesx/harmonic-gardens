class InvoicePdf < Prawn::Document
    def initialize(invoice)
      super()
      @invoice = invoice
        header
        invoice_tag
        subhead
        divider
        table
        # table_content
    end

  def header
    y_position = cursor - 10

    #This inserts an image in the pdf file and sets the size of the image
    bounding_box([0, y_position], :width => 250, :height => 135) do
        stroke_bounds
        text "Harmonic Gardens", size: 14, style: :bold
        text "129 Lancer Rd" + "\n" + "Riverside, CT 06878" + "\n" + "harmonicgardendesign@gmail.com"
    end
    bounding_box([290, y_position], :width => 250, :height => 135) do
        stroke_bounds
        image "#{Rails.root}/app/assets/images/unnamed.png", width: 130, height: 130, :position => :right
    end

    # image "#{Rails.root}/app/assets/images/unnamed.png", width: 130, height: 130
  end

  def invoice_tag
    bounding_box([0, cursor], width: 250, height: 30) do
        stroke_bounds
        text "INVOICE", size: 25, color: "0a5c08"
    end
  end

  def subhead
    y_position = cursor - 10
    bounding_box([0, y_position], width: 250, height: 70) do
        stroke_bounds
        pad_top(8) { text "BILL TO", style: :bold }
        text @invoice.client.full_name + "\n" + @invoice.client.address
    end
    bounding_box([370, y_position], width: 80, height: 70) do
        stroke_bounds
        pad_top(8) {text "INVOICE # " + "\n" + "DATE" + "\n" + "DUE DATE" + "\n" + "TERMS", style: :bold, align: :right}
    end
    bounding_box([460, y_position], width: 80, height: 70) do
        stroke_bounds
        pad_top(8) {text String(@invoice.id) + "\n" + String(@invoice.created_at.strftime("%m-%d-%Y")) + "\n" + "DUE DATE" + "\n" + "Net 30"}
    end
  end


  def divider
    bounding_box([0, cursor - 12], width: 540, height: 10) do
        stroke_color "0a5c08"
        stroke_horizontal_rule
    end
  end

  def table
    y_position = cursor - 25
    bounding_box([-15, y_position], width: 580, height: 25) do
        fill_color "b0e4af"
        fill_rectangle [0, 25], 580, 25
        fill_color "000000"
        bounding_box([15, bounds.top], width: 285, height: 25) do
            stroke_bounds
            text "ACTIVITY", valign: :center
        end
        bounding_box([300, bounds.top], width: 50, height: 25) do
            stroke_bounds
            text "QTY", valign: :center
        end
        bounding_box([400, bounds.top], width: 50, height: 25) do
            stroke_bounds
            text "RATE", valign: :center
        end
        bounding_box([480, bounds.top], width: 60, height: 25) do
            stroke_bounds
            text "AMOUNT", valign: :center
        end
    end
  end
  

  def example
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 25

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 270, :height => 300) do
      text "Lorem ipsum", size: 15, style: :bold
      text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum semper placerat. Aenean mattis fringilla risus ut fermentum. Fusce posuere dictum venenatis. Aliquam id tincidunt ante, eu pretium eros. Sed eget risus a nisl aliquet scelerisque sit amet id nisi. Praesent porta molestie ipsum, ac commodo erat hendrerit nec. Nullam interdum ipsum a quam euismod, at consequat libero bibendum. Nam at nulla fermentum, congue lectus ut, pulvinar nisl. Curabitur consectetur quis libero id laoreet. Fusce dictum metus et orci pretium, vel imperdiet est viverra. Morbi vitae libero in tortor mattis commodo. Ut sodales libero erat, at gravida enim rhoncus ut."
    end

    bounding_box([300, y_position], :width => 270, :height => 300) do
      text "Duis vel", size: 15, style: :bold
      text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
    end

  end

#   def table_content
#     # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
#     # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
#     # Then I set the table column widths
#     # table @invoice.invoice_dates do
#     #   row(0).font_style = :bold
#     #   self.header = true
#     #   self.row_colors = ['DDDDDD', 'FFFFFF']
#     #   self.column_widths = [40, 300, 200]
#     # end
#   end


    class HighlightCallback
        def initialize(options)
            @color = options[:color]
            @document = options[:document]
        end

        def render_behind(fragment)
            original_color = @document.fill_color
            @document.fill_color = @color
            @document.fill_rectangle(fragment.top_left, fragment.width, fragment.height)
            @document.fill_color = original_color
        end
    end

end