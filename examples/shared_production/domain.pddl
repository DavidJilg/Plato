(define (domain tested_domain)
(:requirements :action-costs :negative-preconditions :typing)
(:types 
  Boolean - ROOT
  Camera - MACHINE
  Factory - ROOT
  Machine - ROOT
  Material - ROOT
  Printer - MACHINE
  Robot - MACHINE
  Warehouse - MACHINE
  Workpiece - ROOT
  root - OBJECT
)
(:constants 
  CameraKL - CAMERA
  CameraLemgo - CAMERA
  SmartFactoryKL - FACTORY
  SmartFactoryOWL - FACTORY
  ABS - MATERIAL
  PLA - MATERIAL
  PrusaKL - PRINTER
  PrusaLemgo - PRINTER
  UR5eKL - ROBOT
  UR5eLemgo - ROBOT
  CustomerLocation - WAREHOUSE
  WarehouseKL - WAREHOUSE
  WarehouseLemgo - WAREHOUSE
)
(:predicates 
  (At ?Workpiece - WORKPIECE ?Machine - MACHINE)
  (CanPrint ?Machine - PRINTER ?Material - MATERIAL)
  (CanTransportBetween ?Robot - ROBOT ?Machine - MACHINE ?Machine2 - MACHINE)
  (InFactory ?Machine - MACHINE ?Factory - FACTORY)
  (IsAvailable ?Factory - FACTORY)
  (IsMadeOf ?Workpiece - WORKPIECE ?Material - MATERIAL)
  (IsPrinted ?Workpiece - WORKPIECE)
  (IsReady ?Machine - MACHINE)
  (QualityChecked ?Workpiece - WORKPIECE)
)
(:functions 
  (CO2Efficiency ?factory - FACTORY)
  (CO2EfficiencyWeight)
  (Check_Workpiece_Quality_Cost_0 ?factory - FACTORY ?workpiece - WORKPIECE ?camera - CAMERA)
  (Check_Workpiece_Quality_Cost_1 ?factory - FACTORY ?workpiece - WORKPIECE ?camera - CAMERA)
  (CostEfficiency ?factory - FACTORY)
  (CostEfficiencyWeight)
  (DeliveryCostWeight)
  (DeliveryDelayCost)
  (DeliveryTimeWeight)
  (Distance ?warehouse - WAREHOUSE ?warehouse2 - WAREHOUSE)
  (Print_Workpiece_Cost_0 ?factory - FACTORY ?workpiece - WORKPIECE ?machine - PRINTER ?material - MATERIAL)
  (Print_Workpiece_Cost_1 ?factory - FACTORY ?workpiece - WORKPIECE ?machine - PRINTER ?material - MATERIAL)
  (Transport_Workpiece_Between_Warehouses_Cost_0 ?workpiece - WORKPIECE ?warehouse - WAREHOUSE ?warehouse2 - WAREHOUSE)
  (Transport_Workpiece_Cost_0 ?factory - FACTORY ?workpiece - WORKPIECE ?machine - MACHINE ?machine2 - MACHINE ?robot - ROBOT)
  (Transport_Workpiece_Cost_1 ?factory - FACTORY ?workpiece - WORKPIECE ?machine - MACHINE ?machine2 - MACHINE ?robot - ROBOT)
  (Wait_For_Factory_Availability_Cost_0)
  (total-cost)
  )
(:action Check_Workpiece_Quality
:parameters (?Factory - FACTORY ?Workpiece - WORKPIECE ?Camera - CAMERA)
:precondition 
  (and (At ?workpiece ?camera)
  (IsAvailable ?factory)
  (IsReady ?camera)
  (InFactory ?camera ?factory))
:effect 
  (and (QualityChecked ?workpiece)
  (increase (total-cost) (Check_Workpiece_Quality_Cost_0 ?factory ?workpiece ?camera))
  (increase (total-cost) (Check_Workpiece_Quality_Cost_1 ?factory ?workpiece ?camera)))
)
(:action Print_Workpiece
:parameters (?Factory - FACTORY ?Workpiece - WORKPIECE ?Machine - PRINTER ?Material - MATERIAL)
:precondition 
  (and (CanPrint ?machine ?material)
  (IsAvailable ?factory)
  (IsReady ?machine)
  (not (IsPrinted ?workpiece))
  (InFactory ?machine ?factory))
:effect 
  (and (At ?workpiece ?machine)
  (IsMadeOf ?workpiece ?material)
  (IsPrinted ?workpiece)
  (increase (total-cost) (Print_Workpiece_Cost_0 ?factory ?workpiece ?machine ?material))
  (increase (total-cost) (Print_Workpiece_Cost_1 ?factory ?workpiece ?machine ?material)))
)
(:action Transport_Workpiece
:parameters (?Factory - FACTORY ?Workpiece - WORKPIECE ?Machine - MACHINE ?Machine2 - MACHINE ?Robot - ROBOT)
:precondition 
  (and (At ?workpiece ?machine)
  (CanTransportBetween ?robot ?machine ?machine2)
  (InFactory ?machine ?factory)
  (InFactory ?machine2 ?factory)
  (InFactory ?robot ?factory)
  (IsAvailable ?factory)
  (IsPrinted ?workpiece)
  (IsReady ?robot))
:effect 
  (and (At ?workpiece ?machine2)
  (not (At ?workpiece ?machine))
  (increase (total-cost) (Transport_Workpiece_Cost_0 ?factory ?workpiece ?machine ?machine2 ?robot))
  (increase (total-cost) (Transport_Workpiece_Cost_1 ?factory ?workpiece ?machine ?machine2 ?robot)))
)
(:action Transport_Workpiece_Between_Warehouses
:parameters (?Workpiece - WORKPIECE ?Warehouse - WAREHOUSE ?Warehouse2 - WAREHOUSE)
:precondition 
  (and (At ?workpiece ?warehouse))
:effect 
  (and (At ?workpiece ?warehouse2)
  (not (At ?workpiece ?warehouse))
  (increase (total-cost) (Transport_Workpiece_Between_Warehouses_Cost_0 ?workpiece ?warehouse ?warehouse2)))
)
(:action Wait_For_Factory_Availability
:parameters ()
:precondition 
  (and)
:effect 
  (and  (forall (?Factory - FACTORY)
      (IsAvailable ?factory))
  (increase (total-cost) (Wait_For_Factory_Availability_Cost_0)))
)
)