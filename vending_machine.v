module vending_machine(clk, reset, howmanyticket, origin, destination, money, 
                      costofticket, moneytopay, totalmoney);
  `define TRUE 1'b0;
  `define FALSE 1'b1;
  input clk, reset;
  input [2:0] howmanyticket, origin, destination;
  output reg[7:0] moneytopay, totalmoney;
  output reg[4:0] costofticket;
  input [5:0] money;
// ----------------------------------------------
  reg[2:0] state, next_state;
  reg[6:0] stillneed, refund;
  reg a;
  reg[5:0]m;
// ---------------------------------------------
  parameter station1 = 3'd1; // 車站1
  parameter station2 = 3'd2; // 車站2
  parameter station3 = 3'd3; // 車站3
  parameter station4 = 3'd4; // 車站4
  parameter station5 = 3'd5; // 車站5

  parameter prices5 = 5'd5; // 5元
  parameter prices10 = 5'd10; // 10元
  parameter prices15 = 5'd15; // 15元
  parameter prices20 = 5'd20; // 20元
  parameter prices25 = 5'd25; // 25元

  parameter state0 = 3'd0;
  parameter state1 = 3'd1;
  parameter state2 = 3'd2;
  parameter state3 = 3'd3;
  parameter state22 = 3'd4;
// --------------------------------------------------

  always @(posedge clk) begin // reset
    if (reset == 1'b1) begin
      state <= state3;
    end
    else begin 
      state <= next_state;
    end
  end

  always @(state or m) begin // state內的狀態
    case (state)
      state0: begin 
        totalmoney = 8'd0;
        costofticket = 5'd0;
        moneytopay = 7'd0;
        stillneed = 7'd0;
        refund = 7'd0;
        // enough = 1'b0;
        m = 6'd1;
        a = 1'b0;

        if ((origin == station1 && destination == station1) || (origin == station2 && destination == station2) || 
            (origin == station3 && destination == station3) || (origin == station4 && destination == station4) ||
            (origin == station5 && destination == station5) ) 
          costofticket = prices5; // 決定票價
        else if ((origin == station1 && destination == station2 ) || (origin == station2 && destination == station1) || 
            (origin == station2 && destination == station3) || (origin == station3 && destination == station2) ||
            (origin == station3 && destination == station4) || (origin == station4 && destination == station3) ||
            (origin == station4 && destination == station5) || (origin == station5 && destination == station4)) 
          costofticket = prices10; // 決定票價
        else if ((origin == station1 && destination == station3) || (origin == station2 && destination == station4) || 
            (origin == station3 && destination == station1) || (origin == station3 && destination == station5) ||
            (origin == station4 && destination == station2) || (origin == station5 && destination == station3)) 
          costofticket = prices15; // 決定票價
        else if ((origin == station1 && destination == station4) || (origin == station2 && destination == station5) || 
            (origin == station4 && destination == station1) || (origin == station5 && destination == station2)) 
          costofticket = prices20; // 決定票價
        else if ((origin == station1 && destination == station5) || (origin == station5 && destination == station1)) 
          costofticket = prices25; // 決定票價

        $display("costOfTicket: %d", costofticket);
      end 
      state1: begin
        moneytopay = costofticket * howmanyticket; // 計算總價
        stillneed = moneytopay;
        $display("howmanyTicket: %d", howmanyticket);
        $display("moneytopay: %d", moneytopay);
      end 
      state2: begin
        #10 m = money;
        totalmoney = m + totalmoney; // 計算錢是否付夠     
        m = 6'd0;   
        if (moneytopay > totalmoney) begin
          #5 stillneed = moneytopay - totalmoney;
          $display("totlMoney: %d, notEnoughMoney: %d", totalmoney, stillneed);
        end 
        else begin
          stillneed = 0;
          a = 1'b1;
        end
        // 顯示totalmoney;
        // 顯示stillneed

        if (reset == 1) 
          $display("cancel");
      end

      state22: begin 
        totalmoney = money + totalmoney; // 計算錢是否付夠        
        if (moneytopay > totalmoney) begin
          stillneed = moneytopay - totalmoney;
          $display("totlMoney: %d, notEnoghMoney: %d", totalmoney, stillneed);
        end
        else 
          stillneed = 0;
        // 顯示totalmoney;
        // 顯示stillneed

        if (reset == 1)
          $display("cancel");
      end 

      state3: begin 
        if (reset == 1 && moneytopay > totalmoney) begin 
          refund = totalmoney; // 吐票、找錢
          $display("change(refund): %d", refund);
        end 
        else if (totalmoney >= moneytopay) begin
          refund = totalmoney - moneytopay;
          $display("change(refund): %d", refund);
          $display("howmanyticket: %d", howmanyticket);

        end 
        // 顯示 refund;
        // 顯示 howmanyticket;
      end 

    endcase 
  end 

  always @(state or a) begin // state轉換
    case(state)
      state0: begin
        next_state = state1;
      end
      state1: begin
        if (reset) 
          next_state = state3;
        else 
          next_state = state2;
      end 
      state2: begin

        if (stillneed <= 0 || reset == 1'b1)
          next_state = state3;
        else begin
          next_state = state2;
      end
      end

      state3: begin 
        next_state = state0;
      end

    endcase
  end

// 一個always做reset
// 一個always做state要做的動作
// 一個always做切換state



endmodule 