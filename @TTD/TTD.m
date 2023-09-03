classdef TTD < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                      matlab.ui.Figure
        constantCircuitUpdateSwitch   matlab.ui.control.Switch
        MEASoperatingmodeButton       matlab.ui.control.Button
        WILDoperatingmodeButton       matlab.ui.control.Button
        operatingmodeLabel            matlab.ui.control.Label
        PmodeButton                   matlab.ui.control.Button
        NmodeButton                   matlab.ui.control.Button
        circuitModeLabel              matlab.ui.control.Label
        RC10Button                    matlab.ui.control.Button
        RC1kButton                    matlab.ui.control.Button
        RunButton                     matlab.ui.control.Button
        resistorSelectLabel           matlab.ui.control.Label
        highCollectorButton           matlab.ui.control.Button
        groundedCollectorButton       matlab.ui.control.Button
        CollectorLevelLabel           matlab.ui.control.Label
        DAC0display                   matlab.ui.control.NumericEditField
        DAC0displayLabel              matlab.ui.control.Label
        DAC1display                   matlab.ui.control.NumericEditField
        DAC1displayLabel              matlab.ui.control.Label
        precisionDisplay              matlab.ui.control.DropDown
        precisionLabel                matlab.ui.control.Label
        delayDisplay                  matlab.ui.control.NumericEditField
        delayLabel                    matlab.ui.control.Label
        TextArea                      matlab.ui.control.TextArea
        tuneLabel                     matlab.ui.control.Label 
        tuneDropDown                  matlab.ui.control.DropDown
        variableDACLabel              matlab.ui.control.Label
        variableDACDropDown           matlab.ui.control.DropDown
        targetValueLabel              matlab.ui.control.Label
        targetValueDisplay            matlab.ui.control.NumericEditField
        relationLabel                 matlab.ui.control.Label
        relationDropDown              matlab.ui.control.DropDown
        alphaLabel                    matlab.ui.control.Label
        alphaDisplay                  matlab.ui.control.NumericEditField
        betaLabel                     matlab.ui.control.Label
        betaDisplay                   matlab.ui.control.NumericEditField
        tuneButton                    matlab.ui.control.Button
        DACAxis                       matlab.ui.control.UIAxes
        errorAxis                     matlab.ui.control.UIAxes
        parameterAxis                 matlab.ui.control.UIAxes
        DACparameterMapAxis           matlab.ui.control.UIAxes
        circuitviewPanel              matlab.ui.container.Panel
        controlPanel                  matlab.ui.container.Panel
        tuningPanel                   matlab.ui.container.Panel
        TransistorTestingSystemLabel  matlab.ui.control.Label
        circuitViewObjs 
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 1200 800];
            app.UIFigure.Name = 'TCD';
            app.UIFigure.Resize = 'off';

            % Create TransistorTestingSystemLabel
            app.TransistorTestingSystemLabel = uilabel(app.UIFigure);
            app.TransistorTestingSystemLabel.HorizontalAlignment = 'center';
            app.TransistorTestingSystemLabel.FontSize = 20;
            app.TransistorTestingSystemLabel.Position = [425 764 354 36];
            app.TransistorTestingSystemLabel.Text = 'Transistor Characterization device';

            % Create circuitviewPanel
            app.circuitviewPanel = uipanel(app.UIFigure);
            app.circuitviewPanel.Title = 'Circuit View';
            app.circuitviewPanel.TitlePosition = 'centertop';
            app.circuitviewPanel.Position = [1 0 394 534];

            % Create controlPanel
            app.controlPanel = uipanel(app.UIFigure);
            app.controlPanel.Title = 'Control Panel';
            app.controlPanel.TitlePosition = 'centertop';
            app.controlPanel.Position = [1 534 394 265];

            % Create tuningPanel
            app.tuningPanel = uipanel(app.UIFigure);
            app.tuningPanel.Title = 'Tuning Process';
            app.tuningPanel.TitlePosition = 'centertop';
            app.tuningPanel.Position = [395 0 804 500];

            % Create constantCircuitUpdateSwitch
            app.constantCircuitUpdateSwitch = uiswitch(app.circuitviewPanel);
            app.constantCircuitUpdateSwitch.Position = [300 480 35 16];
            app.constantCircuitUpdateSwitch.FontSize = 10;

            % Create variableDACLabel
            app.variableDACLabel = uilabel(app.tuningPanel);
            app.variableDACLabel.HorizontalAlignment = 'left';
            app.variableDACLabel.FontSize = 12;
            app.variableDACLabel.Position = [10 420 130 20];
            app.variableDACLabel.Text = 'DAC';

            % Create variableDACDropDown
            app.variableDACDropDown = uidropdown(app.tuningPanel);
            app.variableDACDropDown.Position = [80 420 80 20];
            app.variableDACDropDown.Items = ["DAC0" "DAC1"];

            % Create tuneLabel
            app.tuneLabel = uilabel(app.tuningPanel);
            app.tuneLabel.HorizontalAlignment = 'left';
            app.tuneLabel.FontSize = 12;
            app.tuneLabel.Position = [10 450 130 20];
            app.tuneLabel.Text = 'Parameter';

            % Create tuneDropDown
            app.tuneDropDown = uidropdown(app.tuningPanel);
            app.tuneDropDown.Position = [80 450 80 20];
            app.tuneDropDown.Items = ["Vc" "Vb" "Ve" "Vce" "Vbe" "beta" "Ic" "Ib" "Ie"];

            % Create targetValueLabel
            app.targetValueLabel = uilabel(app.tuningPanel);
            app.targetValueLabel.HorizontalAlignment = 'left';
            app.targetValueLabel.FontSize = 12;
            app.targetValueLabel.Position = [10 390 130 20];
            app.targetValueLabel.Text = 'Target';

            % Create targetValueDisplay Display
            app.targetValueDisplay = uieditfield(app.tuningPanel,'numeric');
            app.targetValueDisplay.Position = [80 390 80 20];

            % Create relationLabel
            app.relationLabel = uilabel(app.tuningPanel);
            app.relationLabel.HorizontalAlignment = 'left';
            app.relationLabel.FontSize = 12;
            app.relationLabel.Position = [10 360 130 20];
            app.relationLabel.Text = 'Relation';

            % Create relationDropDown
            app.relationDropDown = uidropdown(app.tuningPanel);
            app.relationDropDown.Position = [80 360 80 20];
            app.relationDropDown.Items = ["Direct" "Inverse"];

            % Create alphaLabel
            app.alphaLabel = uilabel(app.tuningPanel);
            app.alphaLabel.HorizontalAlignment = 'left';
            app.alphaLabel.FontSize = 12;
            app.alphaLabel.Position = [10 330 130 20];
            app.alphaLabel.Text = 'Alpha';

            % Create alphaDisplay Display
            app.alphaDisplay = uieditfield(app.tuningPanel,'numeric');
            app.alphaDisplay.Position = [80 330 80 20];
            app.alphaDisplay.Value = 2;
            app.alphaDisplay.Limits = [1 inf];

            % Create betaLabel
            app.tuneLabel = uilabel(app.tuningPanel);
            app.tuneLabel.HorizontalAlignment = 'left';
            app.tuneLabel.FontSize = 12;
            app.tuneLabel.Position = [10 300 130 20];
            app.tuneLabel.Text = 'Beta';

            % Create betaDisplay Display
            app.betaDisplay = uieditfield(app.tuningPanel,'numeric');
            app.betaDisplay.Position = [80 300 80 20];
            app.betaDisplay.Value = 0.5;
            app.betaDisplay.Limits = [0.5 1];

            % Create tuneButton
            app.tuneButton = uibutton(app.tuningPanel);
            app.tuneButton.Position = [50 250 60 22];
            app.tuneButton.Text = "Tune";
            app.tuneButton.FontSize = 12;

            % Create DACAxes
            app.DACAxis = uiaxes(app.tuningPanel);
            app.DACAxis.Position = [200 250 250 220];
            app.DACAxis.Color = [.96 .96 .96];
            ylabel(app.DACAxis,"DAC value");
            xlabel(app.DACAxis,"Iteration");  

            % Create errorAxis
            app.errorAxis = uiaxes(app.tuningPanel);
            app.errorAxis.Position = [450 250 250 220];
            app.errorAxis.Color = [.96 .96 .96];
            ylabel(app.errorAxis,"Error");
            xlabel(app.errorAxis,"Iteration");   

            % Create parameterAxis
            app.parameterAxis = uiaxes(app.tuningPanel);
            app.parameterAxis.Position = [200 20 250 220];
            app.parameterAxis.Color = [.96 .96 .96];
            ylabel(app.parameterAxis,"Parameter");
            xlabel(app.parameterAxis,"Iteration"); 

            % Create DACparameterMapAxis
            app.DACparameterMapAxis = uiaxes(app.tuningPanel);
            app.DACparameterMapAxis.Position = [450 20 250 220];
            app.DACparameterMapAxis.Color = [.96 .96 .96];
            ylabel(app.DACparameterMapAxis,"Parameter");
            xlabel(app.DACparameterMapAxis,"DAC value"); 

            % Create MEAS button
            app.MEASoperatingmodeButton = uibutton(app.controlPanel);
            app.MEASoperatingmodeButton.Text = 'MEAS';
            app.MEASoperatingmodeButton.Position = [25 200 60 22];

            % Create WILD button
            app.WILDoperatingmodeButton = uibutton(app.controlPanel);
            app.WILDoperatingmodeButton.Text = 'WILD';
            app.WILDoperatingmodeButton.Position = [95 200 60 22]; 
            
            % Create Pmode button
            app.PmodeButton = uibutton(app.controlPanel);
            app.PmodeButton.Text = 'P Mode';
            app.PmodeButton.Position = [25 140 60 22];

            % Create Nmode button
            app.NmodeButton = uibutton(app.controlPanel);
            app.NmodeButton.Text = 'N Mode';
            app.NmodeButton.Position = [95 140 60 22];

            % Create RC10 button
            app.RC10Button = uibutton(app.controlPanel);
            app.RC10Button.Text = '10 Ω';
            app.RC10Button.Position = [25 80 60 22];

            % Create RC1k button
            app.RC1kButton = uibutton(app.controlPanel);
            app.RC1kButton.Text = '1k Ω';
            app.RC1kButton.Position = [95 80 60 22];

            % Create RC10 button
            app.highCollectorButton = uibutton(app.controlPanel);
            app.highCollectorButton.Text = 'High';
            app.highCollectorButton.Position = [25 20 60 22];

            % Create RC1k button
            app.groundedCollectorButton = uibutton(app.controlPanel);
            app.groundedCollectorButton.Text = 'Ground';
            app.groundedCollectorButton.Position = [95 20 60 22];

            % Create Run Button
            app.RunButton = uibutton(app.controlPanel);
            app.RunButton.Text = 'Run';
            app.RunButton.Position = [243 15 75 30];
            app.RunButton.FontSize = 18;

            % Create operating mode label
            app.operatingmodeLabel = uilabel(app.controlPanel);
            app.operatingmodeLabel.HorizontalAlignment = 'center';
            app.operatingmodeLabel.FontSize = 12;
            app.operatingmodeLabel.Position = [25 225 130 20];
            app.operatingmodeLabel.Text = 'Operating Mode';

            % Create circuit mode label
            app.circuitModeLabel = uilabel(app.controlPanel);
            app.circuitModeLabel.HorizontalAlignment = 'center';
            app.circuitModeLabel.FontSize = 12;
            app.circuitModeLabel.Position = [25 165 130 20];
            app.circuitModeLabel.Text = 'Circuit Mode';

            % Create resistor select label
            app.resistorSelectLabel = uilabel(app.controlPanel);
            app.resistorSelectLabel.HorizontalAlignment = 'center';
            app.resistorSelectLabel.FontSize = 12;
            app.resistorSelectLabel.Position = [25 105 130 20];
            app.resistorSelectLabel.Text = 'Resistor Select';

            % Create Collector Level label
            app.CollectorLevelLabel = uilabel(app.controlPanel);
            app.CollectorLevelLabel.HorizontalAlignment = 'center';
            app.CollectorLevelLabel.FontSize = 12;
            app.CollectorLevelLabel.Position = [25 45 130 20];
            app.CollectorLevelLabel.Text = 'Collector Level';

            % Create DAC0 Display
            app.DAC0display = uieditfield(app.controlPanel,'numeric');
            app.DAC0display.Limits = [0 4095];
            app.DAC0display.RoundFractionalValues = 'on';
            app.DAC0display.Position = [250 200 60 22];

            % Create DAC0 display label
            app.DAC0displayLabel = uilabel(app.controlPanel);
            app.DAC0displayLabel.Position = [210 200 40 22];
            app.DAC0displayLabel.Text = "DAC0";

            % Create DAC1 Display
            app.DAC1display = uieditfield(app.controlPanel,'numeric');
            app.DAC1display.Limits = [0 4095];
            app.DAC1display.RoundFractionalValues = 'on';
            app.DAC1display.Position = [250 155 60 22];

            % Create DAC1 display label
            app.DAC1displayLabel = uilabel(app.controlPanel);
            app.DAC1displayLabel.Position = [210 155 40 22];
            app.DAC1displayLabel.Text = "DAC1";           
            
            % Create delayDisplay
            app.delayDisplay = uieditfield(app.controlPanel,'numeric');
            app.delayDisplay.Limits = [0 63];
            app.delayDisplay.RoundFractionalValues = 'on';
            app.delayDisplay.Position = [250 110 60 22];

            % Create delayLabel
            app.delayLabel = uilabel(app.controlPanel);
            app.delayLabel.Position = [210 110 40 22];
            app.delayLabel.Text = "Delay";           
            
            % Create precisionDisplay
            app.precisionDisplay = uidropdown(app.controlPanel);
            app.precisionDisplay.Items = ["1" "2" "4" "8"];
            app.precisionDisplay.Position = [250 65 60 22];

            % Create precisionLabel
            app.precisionLabel = uilabel(app.controlPanel);
            app.precisionLabel.Position = [180 65 60 22];
            app.precisionLabel.Text = "Precision";
            app.precisionLabel.HorizontalAlignment = "right";
  
%             app.createCircuit(app.circuitviewPanel);

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end

    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = TTD(master)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)
            
            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end