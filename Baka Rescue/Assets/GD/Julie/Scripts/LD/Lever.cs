﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Lever : AElement
{
    [SerializeField] private GameObject _wallLever = null;

    public override void ElementalReaction(EElement element)
    {
        switch (element)
        {
            case EElement.THUNDER:
               if (_element == EElement.NONE)
                {
                    Destroy(_wallLever);
                }
                break;
        }
    }

    private void OnTriggerEnter(Collider collider)
    {
        // Check if other is AElement
        AElement other = collider.GetComponent<AElement>();
        if (other != null)
        {
            // React with other's element
            ElementalReaction(other.Element);

            // Destroy other if it's a Projectile
            if (other is ElementalProjectile)
                Destroy(other.gameObject);
        }
    }
}
