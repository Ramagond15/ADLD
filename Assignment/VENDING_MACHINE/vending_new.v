module vending_machine(
  input clk, // clock signal
  input rst, // reset signal
  input [1:0] coin_in, // input coin value (5, 10, 15, 20)
  input [1:0] product_in,// input product selection (0-3)
  output [1:0] change, // output change value (0-3)
  output [3:0] product // output product availability (1 if available, 0 otherwise)
);

  parameter IDLE_STATE = 2'b00;
  parameter SELECT_PRODUCT_STATE = 2'b01;
  parameter ACCEPT_COIN_STATE = 2'b10;
  parameter DISPENSE_PRODUCT_STATE = 2'b11;

  reg [1:0] state = IDLE_STATE;
  reg [3:0] product_count = 4'b1111;
  reg [3:0] product_dispensed = 4'b0000;
  reg [7:0] money = 8'd0;
  reg [1:0] selected_product = 2'b00;
  reg [1:0] accepted_coin = 2'b00;
  reg [1:0] return_change = 2'b00;
  reg [3:0] product_price;
  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state <= IDLE_STATE;
      product_count <= 4'b1111;
      product_dispensed <= 4'b0000;
      money <= 8'd0;
      selected_product <= 2'b00;
      accepted_coin <= 2'b00;
      return_change <= 2'b00;
    end else begin
      case (state)
        IDLE_STATE: begin
          product <= product_count;
          change <= return_change;
          if (product_in != 2'b00) begin
            selected_product <= product_in;
            state <= SELECT_PRODUCT_STATE;
          end else if (coin_in != 2'b00) begin
            accepted_coin <= coin_in;
            state <= ACCEPT_COIN_STATE;
          end
        end
        SELECT_PRODUCT_STATE: begin
          product_count[selected_product] <= 1'b0;
          product_dispensed[selected_product] <= 1'b1;
          money <= money;
          state <= DISPENSE_PRODUCT_STATE;
        end
        ACCEPT_COIN_STATE: begin
          money <= money + {2'b00, accepted_coin};
          if (money >= product_price[selected_product]) begin
            return_change <= money - product_price[selected_product];
            state <= DISPENSE_PRODUCT_STATE;
          end else begin
            state <= ACCEPT_COIN_STATE;
          end
        end
        DISPENSE_PRODUCT_STATE: begin
          product_count <= product_count;
          product_dispensed[selected_product] <= 1'b0;
          change <= return_change;
          return_change <= 2'b00;
          selected_product <= 2'b00;
          accepted_coin <= 2'b00;
          if (product_in != 2'b00) begin
            selected_product <= product_in;
            state <= SELECT_PRODUCT_STATE;
          end else if (coin_in != 2'b00) begin
            accepted_coin <= coin_in;
            state <= ACCEPT_COIN_STATE;
          end else begin
            state <= IDLE_STATE;
          end
        end
      endcase
    end
  end

endmodule
