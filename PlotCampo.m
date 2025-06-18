function PC = PlotCampo(CampoPos, VP)

QuiverFinal = CampoPos;
    hold on;
    for i = 1:size(QuiverFinal)
        x = VP(i,1);
        y = VP(i,2);
        z = VP(i,3);

        u = QuiverFinal(i,1);
        v = QuiverFinal(i,2);
        w = QuiverFinal(i,3);
        
        quiver3(x,y,z, u,v,w, 'Color', 'g', 'LineWidth', .6);
        hold on;
    end

    PC = 1;
end