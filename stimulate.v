module stimulus_f() ;

  reg clk, reset ;
  reg [2:0] howmanyticket, origin, destination ;
  reg [5:0] money ;

  vending_machine vm( .clk(clk),.reset(reset), .howmanyticket(howmanyticket),
                      .origin(origin), .destination(destination), .money(money),
                      .costofticket(), .moneytopay(), .totalmoney() );

  always #5 clk = ~clk;

  initial begin
    // Initialize inputs
    clk = 0 ;
    reset = 1;
/*
    // Apply reset
    #10 reset = 0;

    // Test scenario
    origin = 2;
    destination = 5;        // costOfTicket = 20

    #10 howmanyticket = 2;  // moneyToPay = 40
    #10 money = 10;         // totalMoney: 10, notEnoughMoney: 30
    #10 money = 10;         // totalMoney: 20, notEnoughMoney: 20
    #10 reset = 1;          // Change(返還的錢): 20

    #10 reset = 0;
    origin = 1;
    destination = 5;        // costOfTicket = 20

    #10 howmanyticket = 5;  // moneyToPay = 40
    #10 money = 50;         // totalMoney: 10, notEnoughMoney: 30
    #10 money = 50;         // totalMoney: 20, notEnoughMoney: 20
    #10 money = 50;         // totalMoney: 20, notEnoughMoney: 20

    #10 reset = 1;
    #10 reset = 0;
    origin = 4;
    destination = 1;        // costOfTicket = 20

    #10 howmanyticket = 5;  // moneyToPay = 40
    #10 money = 50;         // totalMoney: 10, notEnoughMoney: 30
    #10 money = 1;         // totalMoney: 20, notEnoughMoney: 20
    #10 money = 5;         // totalMoney: 20, notEnoughMoney: 20
    #10 money = 10;         // totalMoney: 20, notEnoughMoney: 20
    #10 reset = 1;

    // Add more test scenarios as needed
*/
reset = 1 ;
    #10 reset = 0 ;
      origin = 5 ;
      destination = 2 ;                              // costOfTicket = 20
    #10 howmanyticket = 2 ;                          // 40å
    #10 money = 10 ;                // totalMoney: 10, notEnoughMoney: 30
    #10 money = 10 ;                // totalMoney: 20, notEnoughMoney: 20
    #10 money = 1 ;                // totalMoney: 10, notEnoughMoney: 30
    #10 money = 5 ;                // totalMoney: 20, notEnoughMoney: 20
    #10 money = 10 ;                // totalMoney: 10, notEnoughMoney: 30
    #10 money = 10 ;                // totalMoney: 20, notEnoughMoney: 20
    #10 reset = 1 ;                 // change(è¿éçé¢): 20
    
    
    #10 reset = 0;
      origin = 3;
      destination = 1;           // CostOfTicket = 15
    #10 howmanyticket = 3;      // total money = 45
    #10 money= 50;          // 
    #10 reset = 1;                // æ¾5å
  end

endmodule
