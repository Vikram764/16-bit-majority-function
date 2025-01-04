module majority16 (Out, Data);
    input [15:0] Data;
    output Out;
    
    reg Out;
    integer count;
    reg [15:0] i;
    
    always @(*) begin
        count = 0;
        for (i = 0; i < 16; i = i + 1) begin
            if (Data[i] == 1)
                count = count + 1;
        end
        
        if (count >= 9)
            Out = 1;
        else
            Out = 0;
    end
    
endmodule
