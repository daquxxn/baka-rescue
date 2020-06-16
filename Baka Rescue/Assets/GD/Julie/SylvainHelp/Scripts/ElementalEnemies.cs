using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ElementalEnemies : AElement
{

    [SerializeField] private GameObject _waterSphere = null;
    [SerializeField] Enemy2 _enemy2 = null;
    [SerializeField] Enemy1 _enemy1 = null;

    public override void ElementalReaction(EElement element)
{
    switch (element)
    {
        case EElement.WATER:
            if (_element == EElement.FIRE)
            {
                // do whatever you want to do when WATER touch FIRE surface
                _element = EElement.WATER;
                    _waterSphere.SetActive(true);
                }
            else if (_element == EElement.THUNDER)
            {
                // do whatever you want to do when WATER touch THUNDER surface
                _element = EElement.WATER;
                    _enemy2.Stun();
                    _enemy1.Stun();
                    _waterSphere.SetActive(true);
                }
            else if (_element == EElement.WATER)
            {
                  // do whatever you want to do when WATER touch WATER surface
                 _element = EElement.WATER;
                    _waterSphere.SetActive(true);
                }
            else if (_element == EElement.NONE)
            {
                _element = EElement.WATER;
                    _waterSphere.SetActive(true);
                }
            break;
        case EElement.THUNDER:
            if (_element == EElement.FIRE)
            {
                    // do whatever you want to do when THUNDER touch FIRE surface
                    _element = EElement.THUNDER;

            }
            else if (_element == EElement.THUNDER)
            {
                    // do whatever you want to do when THUNDER touch THUNDER surface
                    //stun + lgts
                    _element = EElement.THUNDER;
                }
            else if (_element == EElement.WATER)
            {
                    // do whatever you want to do when THUNDER touch WATER surface
                    _enemy2.Stun();
                    _enemy1.Stun();
                }
            else if (_element == EElement.NONE)
            {
                _element = EElement.THUNDER;

            }
            break;
        case EElement.FIRE:
            if (_element == EElement.FIRE)
            {
                    // do whatever you want to do when FIRE touch FIRE surface
                    // mini explosion bonus apparence
                    _element = EElement.FIRE;
                }
            else if (_element == EElement.THUNDER)
            {
                    // do whatever you want to do when FIRE touch THUNDER surface
                    _element = EElement.FIRE;
                }
            else if (_element == EElement.WATER)
            {
                    // do whatever you want to do when FIRE touch WATER surface
                    _element = EElement.FIRE;
                }
            else if (_element == EElement.NONE)
            {
                    _element = EElement.FIRE;
                }
            break;
    }
}


private void OnTriggerEnter(Collider collider)
{

    // Check if other is AElement
    AElement other = collider.GetComponent<AElement>();
    if (other != null )
    {
            if (other is ElementalProjectile)
            {
                ElementalProjectile elemProj = other.GetComponent<ElementalProjectile>();
                if (elemProj.InstanceID != gameObject.GetInstanceID())
                {
                    // React with other's element
                    ElementalReaction(other.Element);
                    Destroy(elemProj.gameObject);
                }
            }
            else
            {
                // React with other's element
                ElementalReaction(other.Element);
            }
           
        }
}
}
