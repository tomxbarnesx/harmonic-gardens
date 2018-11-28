class InvoicePdf < Prawn::Document
    def initialize(invoice)
      super()
      @invoice = invoice
        header
        invoice_tag
        subhead
        divider
        tablehead
        laborentry
        materials
        total
        footer

        # table_content
    end

    def to_currency(cost)
        zerocheck = cost.to_s.split(".")
        if zerocheck[1].length == 1
          zerocheck[1] << "0"
          return zerocheck.join(".")
        elsif zerocheck[1].length > 2
          rounder = zerocheck.join(".").to_f
          return rounder.round(2).to_s
        end
    end

    def header
        y_position = cursor - 8

        #This inserts an image in the pdf file and sets the size of the image
        bounding_box([0, y_position], :width => 250, :height => 135) do
            #stroke_bounds
            text "Harmonic Gardens", size: 14, style: :bold
            text "129 Lancer Rd" + "\n" + "Riverside, CT 06878" + "\n" + "harmonicgardendesign@gmail.com"
        end
        bounding_box([290, y_position], :width => 250, :height => 135) do
            #stroke_bounds
            image "#{Rails.root}/app/assets/images/unnamed.png", width: 120, height: 120, :position => :right
        end

        # image "#{Rails.root}/app/assets/images/unnamed.png", width: 130, height: 130
    end

    def invoice_tag
        bounding_box([0, cursor], width: 250, height: 30) do
            #stroke_bounds
            text "INVOICE", size: 25, color: "0a5c08"
        end
    end

    def subhead
        y_position = cursor - 10
        bounding_box([0, y_position], width: 250, height: 70) do
            #stroke_bounds
            pad_top(8) { text "BILL TO", style: :bold }
            text @invoice.client.full_name + "\n" + @invoice.client.address
        end
        bounding_box([370, y_position], width: 80, height: 70) do
            #stroke_bounds
            pad_top(8) {text "INVOICE # " + "\n" + "DATE" + "\n" + "DUE DATE" + "\n" + "TERMS", style: :bold, align: :right}
        end
        bounding_box([460, y_position], width: 80, height: 70) do
            #stroke_bounds
            pad_top(8) {text String(@invoice.id) + "\n" + String(@invoice.created_at.strftime("%m-%d-%Y")) + "\n" + "DUE DATE" + "\n" + "Net 30"}
        end
    end


    def divider
        bounding_box([0, cursor - 12], width: 540, height: 10) do
            stroke_color "0a5c08"
            stroke_horizontal_rule
        end
    end

    def tablehead
        y_position = cursor - 25
        bounding_box([-15, y_position], width: 580, height: 25) do
            fill_color "9dbd9c"
            fill_rectangle [0, 25], 580, 25
            fill_color "000000"
            bounding_box([15, bounds.top], width: 285, height: 25) do
                text "ACTIVITY", valign: :center
            end
            bounding_box([330, bounds.top], width: 50, height: 25) do
                text "QTY", valign: :center
            end
            bounding_box([415, bounds.top], width: 50, height: 25) do
                text "RATE", valign: :center
            end
            bounding_box([495, bounds.top], width: 60, height: 25) do
                text "AMOUNT", valign: :center
            end
        end
    end

    def laborentry
        bounding_box([0, cursor], width: 540, height: 30) do
            font_size(10) do
                bounding_box([5, bounds.top], width: 300, height: 30) do
                    pad_top(5){ text "Labor: " + String(@invoice.invoice_dates.count) + " days" + "\n" + String(@invoice.invoice_dates.last.date.strftime("%m-%d")) + " — " + String(@invoice.invoice_dates.first.date.strftime("%m-%d")) }
                end
                bounding_box([325, bounds.top], width: 50, height: 30) do
                    pad_top(5){ text "-" }
                end
                bounding_box([400, bounds.top], width: 50, height: 30) do
                    pad_top(5){ text "-" }
                end
                bounding_box([490, bounds.top], width: 60, height: 30) do
                    pad_top(5){ text "$" + to_currency(@invoice.labor_total(@invoice.id))}
                end
            end
        end
    end

    def materials
        @invoice.material_dates.each do |mat_date|
            bounding_box([0, cursor], width: 540, height: 30) do
                font_size(10) do
                    bounding_box([5, bounds.top], width: 300, height: 30) do
                        pad_top(5){ text mat_date.material.name + "\n" + String(@invoice.invoice_dates.first.date.strftime("%m-%d"))}
                    end
                    bounding_box([325, bounds.top], width: 50, height: 30) do
                        pad_top(5){ text String(mat_date.quantity)}
                    end
                    bounding_box([400, bounds.top], width: 50, height: 30) do
                        pad_top(5){ text "$" + to_currency(mat_date.material.cost)}
                    end
                    bounding_box([490, bounds.top], width: 60, height: 30) do
                        pad_top(5){ text "$" + to_currency(mat_date.instant_total)}
                    end
                end
            end
        end
    end

    def total
        move_down 10
        dash([1, 2, 3, 2, 1],:phase => 6)
        stroke_horizontal_line 5, 540

        y_position = cursor - 8

        bounding_box([325, y_position], width: 100, height: 30) do
            pad_top(10){ text "BALANCE DUE" }
        end
        bounding_box([470, y_position], width: 70, height: 40) do
            pad_top(10) { text "$" + to_currency(@invoice.current_total(@invoice.id)), size: 16 }
        end
    end

    def footer
        bounding_box([180, 0], width: 180, height: 40) do
            text "Thank you for growing with us!" + "\n" + "Online card payments include 4% processing fee" + "\n" + "We also offer 10% cash discount", size: 8, align: :center
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

end