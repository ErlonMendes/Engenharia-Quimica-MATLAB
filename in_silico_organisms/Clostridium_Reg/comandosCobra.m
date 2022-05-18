initCobraToolbox

%Import and Export:

model.regulatoryGenes = modelReg.regulatoryGenes;

model = readCbModel('Cacetobut_824Reg');

load('Cacetobut_824Reg','Cacetobut_824Reg');

model=Cacetobut_824;

writeCbModel(model,'xls','Cacetobut_824Reg');

model = xls2model('Cacetobut_824Reg');

writeCbModel(model,'sbml','Cacetobut_824Reg');

%Optimal flux distributions and growth rates for Escherichia coli: 

model = readCbModel('Cacetobut_824Reg');

load('Cacetobut_824Reg','Cacetobut_824Reg');

model=Cacetobut_824;

solution1 = optimizeCbModel(model);

printFluxVector(model, solution1.x, true, true);

model2 = changeRxnBounds(model, {'EX_glc(e)', 'EX_succ(e)'}, [0 -9], 'l'); 

solution2 = optimizeCbModel(model2); 

printFluxVector(model2, solution2.x, true, true); 

model3 = changeRxnBounds(model, 'EX_o2(e)', 0, 'l'); 

solution3 = optimizeCbModel(model3); 

printFluxVector(model3, solution3.x, true, true);

%Robustness analysis of yeast central metabolism: 

model = readCbModel('Sc_iND750_GlcMM'); 

robustnessAnalysis(model, 'PGK', 20); 

robustnessAnalysis(model, 'TPI', 20); 

%Dynamic growth simulations (batch growth) of E. coli on glucose minimal media: 

model = readCbModel('Ec_iJR904_GlcMM'); 

model = changeRxnBounds(model, {'EX_glc(e)','EX_o2(e)'},[-10 -18], 'l'); 

substrateRxns = {'EX_glc(e)'}; 

initConcentrations = 10; initBiomass = .035; 

timeStep = .25; nSteps = 20; 

plotRxns = {'EX_glc(e)','EX_ac(e)'}; 

dynamicFBA(model,substrateRxns,initConcentrations,initBiomass,timeStep,nSteps,plotRxns); 

%Single and double gene deletion phenotypes of yeast metabolic genes: 

model = readCbModel('Sc_iND750_GlcMM'); 

grRatioFBA = singleGeneDeletion(model,'FBA'); 

grRatioMOMA = singleGeneDeletion(model,'lMOMA'); 

plot(1:length(grRatioFBA), [sort(grRatioMOMA) sort(grRatioFBA)],'.');xlabel('Gene');ylabel('Razão entre as taxas de crescimento das cepas mutada e selvagem');legend('lMOMA','FBA'); 

grRatioDouble = doubleGeneDeletion(model,'FBA'); 

interactions = findEpistaticInteractions(model,grRatioDouble); 

nInteractions = sum(interactions); 

plot(sort(nInteractions(nInteractions > 0)),'-');xlabel('Gene');ylabel('Número de interações'); 

%Flux variability in E. coli central metabolic pathways: 

model = readCbModel('Ec_iJR904_GlcMM'); 

[minFlux,maxFlux] = fluxVariability(model,90); 

rxnNames = {'PGI','PFK','FBP','FBA','TPI','GAPD','PGK','PGM','ENO','PYK','PPS','G6PDH2r','PGL','GND','RPI','RPE','TKT1','TKT2','TALA'}; 

rxnID = findRxnIDs(model,rxnNames); 

printLabeledData(model.rxns(rxnID),[minFlux(rxnID) maxFlux(rxnID) maxFlux(rxnID)-minFlux(rxnID)],true,3); 

%Analyzing flux correlations in E. coli glycolysis using sampling: 

model = readCbModel('Ec_iJR904_GlcMM'); 

sol = optimizeCbModel(model); 

growthRate = sol.f; 

model = changeRxnBounds(model,'BiomassEcoli',0.9*growthRate,'l'); 

[modelSampling,samples] = sampleCbModel(model,'Ec_iJR904_GlcMM_flux'); 

rxnNames = {'PGI','PFK','FBP','FBA','TPI','GAPD','PGK','PGM','ENO','PYK','PPS'}; 

sampleScatterMatrix(rxnNames,modelSampling,samples); 

%Correlated reaction sets in the Saccharomyces cerevisiae metabolic network: 

model = readCbModel('Sc_iND750_GlcMM'); 

[modelSampling,samples] = sampleCbModel(model,'Sc_iND750_GlcMM_flux'); 

[sets,setNumber] = identifyCorrelSets(modelSampling,samples); 

selectRxns = setNumber > 0 & setNumber <= 5; 

outputRxnList = model.rxns(selectRxns); 

outputSetNumber = setNumber(selectRxns); 

outputNetworkCytoscape(model,'iND750_correlSets',outputRxnList,outputSetNumber,40); 

%Visualization

map = readCbMap('ecoli_core_map.txt');

changeCbMapOutput('svg');

drawCbMap(map);

%FBA map

map = readCbMap('ecoli_core_map.txt');

changeCbMapOutput('svg');

model = readCbModel('ecoli_core_model.xml');

solution = optimizeCbModel(model);

drawFlux(map, model, solution.x, [], 'FileName', 'EcoreOptFlux1.svg');

drawFlux(map, model, solution.x, [], 'ZeroFluxWidth', 1, 'lb', -15, 'ub', 15, 'FileName', 'EcoreOptFlux2.svg');

%FVA map

map = readCbMap('ecoli_core_map.txt');

changeCbMapOutput('svg');

model = readCbModel('ecoli_core_model.xml');

[minFlux, maxFlux] = fluxVariability(model,90);

drawFluxVariability(map, model, minFlux, maxFlux, [], 'FileName', 'EcoreFluxVariability.svg');

%Parsimonious FBA

map = readCbMap('ecoli_core_map.txt');

model = readCbModel('ecoli_core_model.xml');

[pFBAGeneClasses, pFBARxn] = pFBA(model, 'map', map, 'mapOutName', 'Ecore_pFBA_glu.svg');

model = changeRxnBounds(model,'EX_glc(e)',0,'l');

model = changeRxnBounds(model,'EX_ac(e)',-10,'l');

[pFBAGeneClasses, pFBARxn] = pFBA(model, 'map', map, 'mapOutName', 'Ecore_pFBA_ac.svg');

%Gap Filling

outputMets = detectDeadEnds(model);

DeadEnds = model.mets(outputMets)

model = changeRxnBounds(model, model.rxns(logical(model.rev)), -1e6, 'l');

model = changeRxnBounds(model, model.rxns, 1e6, 'u');

exchangeRxns = model.rxns(findExcRxns(model));

model = changeRxnBounds(model, exchangeRxns, -1, 'l');

[allGaps, rootGaps, downstreamGaps] = gapFind(model)

%Metabolic engineering

model = readCbModel('ecoli_core_model.xml');

model = changeRxnBounds(model, {'EX_o2(e)', 'EX_glc(e)'}, [0, -20], 'l');

selectedRxns = {model.rxns{ [1, 3:5, 7:8, 10, 12, 15:16, 18, 40:41, 44, 46, 48:49, 51, 53:55, 57, 59:62, 64:68, 71:77, 79:83, 85:86, 89:95]}};

options.targetRxn = 'EX_lac-D(e)';

options.vMax = 1000;

options.numDel = 5;

options.numDelSense = 'L'; %Direction of # of deletions constraint (G/E/L)

constrOpt.rxnList = {'Biomass_Ecoli_core_N(w/GAM)-Nmet2', 'ATPM'}; %Explicitly constrained reaction options

constrOpt.values = [0.05, 8.39];

constrOpt.sense = 'GE'; %Constraint senses for constrained reactions (G/E/L)

optKnockSol = OptKnock(model, selectedRxns, options, constrOpt);

[gdlsSolution, bilevelMILPproblem, gdlsSolutionStructs] = GDLS(model, 'EX_lac-D(e)', 'minGrowth', 0.05, 'selectedRxns', selectedRxns, 'maxKO', 5, 'nbhdsz', 3); %'nbhdsz' = Neighborhood size

model = readCbModel('Ca_ATCC824_Glc');

selectedRxns = model.rxns';

selExchange = findExcRxns(model,true,false);

p = find(selExchange~=0);

selectedRxns(p) = []; %Elimina as exchange reactions

selectedRxns(411:501) = []; %Elimina as reações de manutenção celular

selectedRxns(1:72) = []; %Elimina as reações de transporte

selectedRxns(107:319) = [];

selectedRxns(45:68) = [];

selectedRxns(1:22) = [];

options.targetRxn = 'EX_H2(e)';

options.vMax = 1000;

options.numDel = 5;

options.numDelSense = 'L'; %Direction of # of deletions constraint (G/E/L)

constrOpt.rxnList = {'BIOMASS'}; %Explicitly constrained reaction options

constrOpt.values = [0.05];

constrOpt.sense = 'GE'; %Constraint senses for constrained reactions (G/E/L)

optKnockSol = OptKnock(model, selectedRxns, options, constrOpt);

[gdlsSolution, bilevelMILPproblem, gdlsSolutionStructs] = GDLS(model, 'EX_H2(e)', 'minGrowth', 0.05, 'selectedRxns', selectedRxns, 'maxKO', 5);

%Simulate maximum growth of regulated model:
%Load Cacetobut_824Reg_glc

FBAsols = optimizeRegModel(modelReg);

printFluxVector(modelReg, FBAsols{1,1}.x, true, true);

initConcentrations = 5 ; initBiomass = .035;

substrateRxns = {'EX_glc(e)'};

timeStep = .05; nSteps = 200;

plotRxns = {'EX_glc(e)','EX_ac(e)','EX_but(e)','EX_h2(e)','EX_co2(e)'};

dynamicRFBA(modelReg,substrateRxns,initConcentrations,initBiomass,timeStep,nSteps,plotRxns);

%Dynamic growth simulations (batch growth) of C. acetobutylicum:
%Load Cacetobut_824Reg_lcts

initConcentrations = [5 5]; initBiomass = .035;

substrateRxns = {'EX_glc(e)','EX_lcts(e)'};

timeStep = .08; nSteps = 200;

plotRxns = {'EX_glc(e)','EX_lcts(e)','EX_ac(e)','EX_but(e)','EX_h2(e)','EX_co2(e)'};

dynamicRFBA(modelReg,substrateRxns,initConcentrations,initBiomass,timeStep,nSteps,plotRxns);

%Load Cacetobut_824Reg_sucr

initConcentrations = [5.5 4.5]; initBiomass = .035;

substrateRxns = {'EX_glc(e)','EX_sucr(e)'};

timeStep = .05; nSteps = 200;

plotRxns = {'EX_glc(e)','EX_sucr(e)','EX_ac(e)','EX_but(e)','EX_h2(e)','EX_co2(e)'};

dynamicRFBA(modelReg,substrateRxns,initConcentrations,initBiomass,timeStep,nSteps,plotRxns);

%Load Cacetobut_824Reg_malt

initConcentrations = [4 4]; initBiomass = .035;

substrateRxns = {'EX_glc(e)','EX_malt(e)'};

timeStep = .05; nSteps = 200;

plotRxns = {'EX_glc(e)','EX_malt(e)','EX_ac(e)','EX_but(e)','EX_h2(e)','EX_co2(e)'};

dynamicRFBA(modelReg,substrateRxns,initConcentrations,initBiomass,timeStep,nSteps,plotRxns);

%Load Cacetobut_824Reg_glyc

FBAsols = optimizeRegModel(modelReg);

printFluxVector(modelReg, FBAsols{1,1}.x, true, true);

initConcentrations = [5 5]; initBiomass = .035;

substrateRxns = {'EX_glc(e)','EX_glyc(e)'};

timeStep = .07; nSteps = 200;

plotRxns = {'EX_glc(e)','EX_glyc(e)','EX_ac(e)','EX_but(e)','EX_etoh(e)','EX_btoh(e)','EX_h2(e)','EX_co2(e)'};

dynamicRFBA(modelReg,substrateRxns,initConcentrations,initBiomass,timeStep,nSteps,plotRxns);
