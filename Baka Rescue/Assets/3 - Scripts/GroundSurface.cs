using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundSurface : MonoBehaviour
{
    [SerializeField] private EStepSurface _stepSurface = EStepSurface.WOOD;
    public EStepSurface StepSurface => _stepSurface;
}
