function [SpikeMat,Vm] = LIFNeuron(dt,tVec,TauM,tRefact,Vth,EL,VReset,VSpike,RM,IExc)
    Vm = zeros(size(tVec));
    Vm(1) = EL;
    SpikeMat = zeros(size(tVec)); %ms
    i1 = 1;
    while i1 < length(Vm)
        if Vm(i1)>Vth
            Vm(i1) = VSpike;
            SpikeMat(i1) = i1*dt;
            temp = floor(tRefact/dt);
            Vm(i1+1:i1+temp) = VReset;
            i1=i1+temp+1;
        else
            dv = ((-Vm(i1) + RM*IExc(i1))/TauM) * dt;
            Vm(i1+1) = Vm(i1) + dv;
            i1=i1+1;
        end
    end
    SpikeMat = nonzeros(SpikeMat)';
end

