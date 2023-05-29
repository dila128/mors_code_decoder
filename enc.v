module MorsKodDecoder(
  input wire clk,
  input wire rst,
  output reg led_mavi,
  output reg led_kirmizi
);

  reg [2:0] durum;
  reg [3:0] adet_nokta;
  reg [3:0] adet_cizgi;

  parameter dot_a = 2;
  parameter dot_l = 4;
  parameter dot_i = 2;
  parameter dot_bosluk = 4;
  parameter dash_t = 2;
  parameter dash_o = 6;
  parameter dot_p = 4;
  parameter dot_u = 2;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      durum <= 3'b000;  // Başlangıç durumu
      adet_nokta <= 4'b0000;
      adet_cizgi <= 4'b0000;
      led_mavi <= 1'b0;
      led_kirmizi <= 1'b0;
    end
    else begin
      case (durum)
        3'b000: begin  // "a" harfi, ".-"
          if (adet_nokta < dot_a)
            adet_nokta <= adet_nokta + 1;
          else begin
            durum <= 3'b001;
            adet_nokta <= 4'b0000;
          end
          led_mavi <= 1'b1;
          led_kirmizi <= 1'b0;
        end

        3'b001: begin  // "l" harfi, ".-.."
          if (adet_nokta < dot_l)
            adet_nokta <= adet_nokta + 1;
          else begin
            durum <= 3'b010;
            adet_nokta <= 4'b0000;
          end
          led_mavi <= 1'b1;
          led_kirmizi <= 1'b0;
        end

        3'b010: begin  // "i" harfi, ".."
          if (adet_nokta < dot_i)
            adet_nokta <= adet_nokta + 1;
          else begin
            durum <= 3'b011;
            adet_nokta <= 4'b0000;
          end
          led_mavi <= 1'b1;
          led_kirmizi <= 1'b0;
        end

        3'b011: begin  // boşluk, " "
          if (adet_nokta < dot_bosluk)
            adet_nokta <= adet_nokta + 1;
          else begin
            durum <= 3'b100;
            adet_nokta <= 4'b0000;
          end
          led_mavi <= 1'b0;
          led_kirmizi <= 1'b0;
        end

        3'b100: begin  // "t" harfi, "-"
          if (adet_cizgi < dash_t)
            adet_cizgi <= adet_cizgi + 1;
          else begin
            durum <= 3'b101;
            adet_cizgi <= 4'b0000;
          end
          led_mavi <= 1'b0;
          led_kirmizi <= 1'b1;
        end

        3'b101: begin  // "o" harfi, "---"
          if (adet_cizgi < dash_o)
            adet_cizgi <= adet_cizgi + 1;
          else begin
            durum <= 3'b110;
            adet_cizgi <= 4'b0000;
          end
          led_mavi <= 1'b0;
          led_kirmizi <= 1'b1;
        end

        3'b110: begin  // "p" harfi, ".--."
          if (adet_nokta < dot_p)
            adet_nokta <= adet_nokta + 1;
          else begin
            durum <= 3'b111;
            adet_nokta <= 4'b0000;
          end
          led_mavi <= 1'b1;
          led_kirmizi <= 1'b0;
        end

        3'b111: begin  // "u" harfi, "..-"
          if (adet_nokta < dot_u)
            adet_nokta <= adet_nokta + 1;
          else begin
            durum <= 3'b000;  // Başlangıç durumuna dön
            adet_nokta <= 4'b0000;
          end
          led_mavi <= 1'b1;
          led_kirmizi <= 1'b0;
        end
      endcase
    end
  end

endmodule
