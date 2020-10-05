using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public abstract class AElement : MonoBehaviour, IElement
{
    // Current element on child object
    [SerializeField] protected EElement _element = EElement.NONE;

    public EElement Element { get{return _element;} }

    // Handle Element x Element
    public abstract void ElementalReaction(EElement element);
}
